> ./set.js
  fs > existsSync
  @3-/write
  @3-/read
  semver > compare

DAY = 864e5

daystr = (date)=>date.toISOString().slice(0,10)

< (ver_yml, project, version, duration)=>
  ver_li = if existsSync(ver_yml) then read(ver_yml).trim().split('\n') else []

  release = {}

  now_ts = new Date / DAY

  beta = now_ts - duration

  dist_ts = Object.entries {
    beta
    stable: beta - duration
  }

  alpha = 1

  can_dist = {}

  for i,pos in ver_li
    i = i.trim()
    if not i or i.startsWith('#')
      continue
    i = i.split(' ')

    [ver, date, dist] = i

    switch compare(ver, version)
      when 0
        return
      when 1
        alpha = 0

    i[1] = ts = Math.round new Date(date) / DAY

    dist = if dist then dist.split('|') else []
    i[2] = dist
    for j from dist
      t = release[j]
      if t
        if compare(t, ver) < 0
          release[j] = ver
      else
        release[j] = ver

    for [channel, before] from dist_ts
      if dist.includes channel
        continue
      if ts < before
        pre = can_dist[channel]
        if pre and compare(pre[1][0],ver) > 0
          continue
        can_dist[channel] = [pos, i]

  txt =[
    version
    daystr(new Date)
  ]

  this_release = []
  if alpha
    await set 'alpha', project, version

  for [i] from dist_ts
    if not release[i]
      await set i, project, version
      this_release.push i
      delete can_dist[i]

  if this_release.length > 0
    txt.push this_release.join('|')

  for [channel, [pos, i]] from Object.entries can_dist
    if compare(release[channel], i[0]) < 0
      await set channel, project, i[0]
      i[2].push channel
      # 不修改i[2]为字符串，避免一个版本发布多个频道的时候出错
      ver_li[pos] = i[0]+' '+daystr(new Date(i[1]*DAY))+' '+i[2].join('|')

  ver_li.push txt.join(' ')
  write(ver_yml, ver_li.join('\n'))

  return
