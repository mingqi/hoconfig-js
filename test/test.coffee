hoconfig = require('../lib/hoconfig')
try
  r = hoconfig('./test/test.conf')
  console.log(r)
  # console.log("-----------")
  # console.log(JSON.stringify(r))
  # console.log(r.address.country)
  # console.log(r.stringNotSupportEscape)

catch e
    console.log(e)

