var fs = require('fs')
config = fs.readFileSync('./test.conf', {encoding:'utf-8'})
console.log(config)

p = require('./parser')
try{
  r = p.parse(config)
  console.log("-----------")
  console.log(JSON.stringify(r))
  console.log(r.address.country)
}
catch (e){
    console.log(e)
}
