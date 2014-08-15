/*
Test
  = a:identifier valueSeparator b:identifier  {return [a,b]}
*/


HOConfig 
  = object:object {return object}


WhiteSpace "whitespace"
  = "\t"
  / "\v"
  / "\f"
  / " "
  / "\u00A0"
  / "\uFEFF"
  / Zs

// Separator, Space
Zs = [\u0020\u00A0\u1680\u2000-\u200A\u202F\u205F\u3000]

LineTerminator
  = [\n\r\u2028\u2029]

LineComment
  = "#" (!LineTerminator .)*

LineTerminatorSequence "end of line"
  = "\n"
  / "\r\n"
  / "\r"
  / "\u2028"
  / "\u2029"

_
  = (WhiteSpace / LineComment ) *
__
  = (WhiteSpace / LineTerminatorSequence / LineComment) *

valueSeparator = _ (LineTerminatorSequence / ',') __
nameSeparator = _ (':' / '=') _
beginObject    =  "{" 
endObject      =  "}" 
beginArray     =  "[" 
endArray       =  "]" 


/* -----  Object ----- */

object
  = __ first:member rest:(valueSeparator m:member {return m} )* __
    {
      var result = {}, i
      result[first.name] = first.value
      for (i = 0; i< rest.length; i++){
        result[rest[i].name] = rest[i].value
      }
      return result
    }

member
  = name:identifier nameSeparator value:value{
      return { name: name, value: value };
    }

innerObject = beginObject object:object endObject {return object}

/* ----- Values ----- */

value
  = string
  / innerObject
  / array



false = "false" { return false; }
null  = "null"  { return null;  }
true  = "true"  { return true;  }


/* ----- Numbers ----- */

number "number"
  = minus? int frac? exp? { return parseFloat(text()); }

decimal_point = "."
digit1_9      = [1-9]
e             = [eE]
exp           = e (minus / plus)? DIGIT+
frac          = decimal_point DIGIT+
int           = zero / (digit1_9 DIGIT*)
minus         = "-"
plus          = "+"
zero          = "0"

/* ----- 5. Arrays ----- */

array
  = beginArray __
    values:(
      first:value
      rest:(valueSeparator v:value { return v; })*
      { return [first].concat(rest); }
    )?
    __ endArray
    { return values !== null ? values : []; }


/* ----- Strings ----- */

string "string"
  = doubleQuotation chars:doubleQuotaChar* doubleQuotation { return chars.join(""); }
  / singleQuotation chars:singleQuotaChar* singleQuotation { return chars.join(""); }
  / autoParseString 

autoParseString "automatically parse string"
  = name:[^="_':{}\[\]\t\n\r #,]+ 
  {
    literal = name.join("")
    if(!isNaN(literal)){
      return parseFloat(literal) 
    }

    if(literal.toLowerCase() == 'false'){
      return false
    }
    if(literal.toLowerCase() == 'true'){
      return true
    }
    if(literal.toLowerCase() == 'null'){
      return null
    }

    return literal;
  }

identifier "identifier"
  = name:[a-zA-Z0-9_.-]+ {return name.join("")}


doubleQuotaChar
  = [^"]

singleQuotaChar
  = [^']

doubleQuotation = '"'
singleQuotation = "'"
escape         = "\\"

/* See RFC 4234, Appendix B (http://tools.ietf.org/html/rfc4627). */
DIGIT  = [0-9]
HEXDIG = [0-9a-f]i