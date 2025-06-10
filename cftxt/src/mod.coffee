#!/usr/bin/env coffee

> @3-/cf
  @3-/cf/setTXT.js

{GET, POST, DELETE} = cf

export default (project, channel, txt)=>
  # [
  #   project
  #   channel
  # ] = process.argv.slice(2)
  {HOST_LI} = process.env
  HOST_LI = HOST_LI.split(' ')

  zone_id_li = (await Promise.all(
    HOST_LI.map (i)=>GET('?name='+i)
  )).map ([i])=>i.id

  content = JSON.stringify(txt)
  await Promise.allSettled HOST_LI.map (host, pos)=>
    setTXT(
      project+'-'+channel
      host
      zone_id_li[pos]
      content
    )
  return

