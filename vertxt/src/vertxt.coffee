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

  ver_set = new Set
  for channel_ver from [release, dist]
    for i in Object.values channel_ver
      ver_set.add i

  console.log ver_set


  # for [channel, ver] from Object.entries dist
  #   await setTXT channel, project, ver
  # await save()
  return
