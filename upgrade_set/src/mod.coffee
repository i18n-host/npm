#!/usr/bin/env coffee

> @3-/cf

{GET, POST, DELETE} = cf

{HOST_LI,TXT} = process.env

HOST_LI = HOST_LI.split(' ')

zone_id_li = (await Promise.all(
  HOST_LI.map (i)=>GET('?name='+i)
)).map ([i])=>i.id

[
  project
  channel
] = process.argv.slice(2)

content = JSON.stringify(TXT)

await Promise.allSettled HOST_LI.map (host, pos)=>
  id = zone_id_li[pos]
  name =  project+'-'+channel+'.'+host
  console.log name
  li = await GET "#{id}/dns_records?type=TXT&name="+name
  await Promise.all li.map (i)=>
    DELETE(
      id+'/dns_records/'+i.id
    )
  await POST(
    id+'/dns_records'
    {
      type: 'TXT'
      name
      content
      ttl: 600
    }
  )
  return


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
