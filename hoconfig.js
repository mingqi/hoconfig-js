var parser = require('./parser')
var fs = require('fs')

module.exports = hoconfig = function (config) {
  var content = null
  if(typeof config == 'string'){
    if(fs.existsSync(config)){
      content = fs.readFileSync(config, {encoding:'utf-8'})
    }else{
      content = config
    }
  }else if( config instanceof Buffer ){
    content = config.toString()
  }else{
    throw Error("input config is illegal, it must be a string, file path or Buffer")
  }

  try{
    return parser.parse(content)
  }catch( e ){
    throw Error(e.message+", line:"+e.line+",column:"+e.column)
  }
}