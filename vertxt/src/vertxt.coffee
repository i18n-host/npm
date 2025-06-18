> ./setTXT.js
  ./released.js

< (project, version, duration)=>
  r = await released project, version, duration

  console.log r

  if not r
    return

  [

    release
    dist
    save
  ] = r

  for [channel, ver] from Object.entries dist
    await setTXT channel, project, ver

  await save()
  return
