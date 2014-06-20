hoconfig-js
===========

# Introduce
HOConfig (Human Optimized Config) keep the semantics from JSON, but make it more convenient as a human-editable config file format for reading and typing.

# examples
```
# hoconfig is a json like configuration syntax, optimized for human reading and typing
# - support single line comment
# - omit root braces
# - the "," between member is optional

name : "Mingqi Shao",       # - string can be double quotation
title : 'engineer'          # - string can be single quotation. 
sex : male                  # - string even can no quotation
age : 33                    # - number will be auto detected
married : true              # - boolean as well
job : null                  # - support null. 
kids = 2                    # - key value separator can be = other than :
languanges : [
    java, ruby, clojure
    python, node.js]        # - this is Array
address :  {                # - this is recursive object
    country : china
    city : beijing
  }

```

# install
```bash
npm install hoconfig-js
```

# use
```javascript
var hoconfig = require('hoconfig-js')
config = hoconfig('/the/path/of/config')
```
the return value of hoconfig() is a object. hocnfig also accept string and buffer other than file path
