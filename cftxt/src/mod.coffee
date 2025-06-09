#!/usr/bin/env coffee

> @3-/cf
  @3-/cf/setTXT.js
{GET, POST, DELETE} = cf


setTxt = =>
  [
    project
    channel
  ] = process.argv.slice(2)
  {HOST_LI,TXT} = process.env
  HOST_LI = HOST_LI.split(' ')

  zone_id_li = (await Promise.all(
    HOST_LI.map (i)=>GET('?name='+i)
  )).map ([i])=>i.id

  content = JSON.stringify(TXT)
  await Promise.allSettled HOST_LI.map (host, pos)=>
    setTXT(
      project+'-'+channel
      host
      zone_id_li[pos]
      content
    )
  return

# https://github.com/up51/v
# https://
# github.com/i18n-site/rust/releases/download/i18n.site
# /0.2.104/x86_64-pc-windows-msvc.tar

# ver
# github.com/up51/v

# console.log await GET('?name=018007.xyz')
# // cf.get)
#
# // curl -X POST "https://api.cloudflare.com/client/v4/zones/<YOUR_ZONE_ID>/dns_records" \
# //      -H "Authorization: Bearer <YOUR_API_TOKEN>" \
# //      -H "Content-Type: application/json" \
# //      --data '{
# //        "type": "TXT",
# //        "name": "i18-nightly.i18-nightly",
# //        "content": "123",
# //        "ttl": 600,
# //        "proxied": false
# //      }'
