> ./setTXT.js
  ./released.js
  ./ghdist.js

< (project, version, duration)=>
  r = await released project, version, duration

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

  ghdist(project, ver_set)

  # return
  for [channel, ver] from Object.entries dist
    await setTXT channel, project, ver
  await save()
  return
