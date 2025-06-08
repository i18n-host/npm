#!/usr/bin/env coffee

> @3-/cf

{HOST_LI} = process.env

{GET} = cf

zone_id_li = (await Promise.all(
  HOST_LI.split(' ').map (i)=>GET('?name='+i)
)).map ([i])=>i.id

console.log zone_id_li

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
