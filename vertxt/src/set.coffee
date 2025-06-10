> @3-/verb64/verb64E.js
  @3-/cf
  @3-/cf/setTXT.js

{
  GET
} = cf

{
  TXT_HOST_LI
  DOWN_HOST_LI
  GITHUB_OWNER
  GITHUB_REPO
} = process.env

TXT_HOST_LI = TXT_HOST_LI.split(' ')

ZONE_ID_LI = (await Promise.all(
  TXT_HOST_LI.map (i)=>GET('?name='+i)
)).map ([i])=>i.id

SET_TXT = ";G#{GITHUB_OWNER}/#{GITHUB_REPO};"+DOWN_HOST_LI

< (channel, project, version)=>
  verb64 = verb64E version
  txt = JSON.stringify verb64 + SET_TXT

  prefix = project+'-'+channel

  await Promise.all TXT_HOST_LI.map (host, pos)=>
    console.log prefix+'.'+host
    setTXT(
      prefix
      host
      ZONE_ID_LI[pos]
      txt
    )
  return

