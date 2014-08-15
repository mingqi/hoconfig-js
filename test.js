var fs = require('fs')
config = fs.readFileSync('./test.conf', {encoding:'utf-8'})
// console.log(config)

p = require('./parser')
try{
  r = p.parse(config)
  console.log(r)
  // console.log("-----------")
  // console.log(JSON.stringify(r))
  // console.log(r.address.country)
  // console.log(r.stringNotSupportEscape)
}
catch (e){
    console.log(e)
}
