parser = require './parser'
fs = require 'fs'
us = require 'underscore'
Humanable = require 'humanable'

to_boolean = (str) ->
  switch str.toLowerCase()
    when "true" then true
    when "false" then false
    else null

to_float = (str) ->
  if /^\d+(\.\d*)?$/.test(str)
    return parseFloat str
  return null

to_size = (str) ->
  hum = Humanable(['b,B,byte',1024,'kb,KB,k,K',1024, 'm, M, mb, MB', 1024, 'g, G, gb, GB', 1024, 'T, TB, t']) 
  try
    hum.parse str 
  catch e
    return null

to_duration = (str) ->
  hum = Humanable(['msec', 1000, 'second, sec', 60, 'min, minute',60, 'hour',24, 'day'])
  try
    hum.parse str 
  catch e
    return null


smart = (obj) ->
  result = null
  switch

    when us.isArray obj 
      result = []
      for a in obj
        result.push smart(a)
    when us.isObject(obj)
      ## object must behand array because array is also a object
      result = {}
      us.pairs(obj).map ([key, value]) ->
        result[key] = smart(value)


    when us.isString obj
      if obj.toLowerCase() == 'false'
        return false
      if obj.toLowerCase() == 'true'
        return true

      result = to_float(obj) or to_size(obj) or to_duration(obj) or obj

  return result


###
options:
  human: true or false. default is false. support human readable parse
###
module.exports = hoconfig = (config, options) -> 
  content = null
  if us.isString(config)
    if(fs.existsSync(config))
      content = fs.readFileSync(config, {encoding:'utf-8'})
    else
      content = config
  else if( config instanceof Buffer )
    content = config.toString()
  else
    throw new Error("input config is illegal, it must be a string, file path or Buffer")
  
  try
    obj = parser.parse(content)
  catch e
    throw new Error(e.message+", line:"+e.line+",column:"+e.column)
  return smart(obj)
