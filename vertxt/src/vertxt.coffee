> ./setTXT.js
  semver > compare
  ./released.js

daystr = (date)=>date.toISOString().slice(0,10)

< (project, version, duration)=>
  r = await released project, version, duration

  console.log r

  if not r
    return

  [

    verSet
    release
    dist_ts
    alpha
    can_dist
    ver_li
  ] = r

  txt =[
    version
    daystr(new Date)
  ]

  this_release = []
  if alpha
    await setTXT 'alpha', project, version

  for [i] from dist_ts
    if not release[i]
      await setTXT i, project, version
      this_release.push i
      delete can_dist[i]

  if this_release.length > 0
    txt.push this_release.join('|')

  for [channel, [pos, i]] from Object.entries can_dist
    if compare(release[channel], i[0]) < 0
      await setTXT channel, project, i[0]
      i[2].push channel
      # 不修改i[2]为字符串，避免一个版本发布多个频道的时候出错
      ver_li[pos] = i[0]+' '+daystr(new Date(i[1]*864e5))+' '+i[2].join('|')

  ver_li.push txt.join(' ')
  await verSet(ver_li.join('\n'))

  return
