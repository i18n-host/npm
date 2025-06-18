#!/usr/bin/env coffee

> ./verdb.js
  ./setTXT.js
  semver > compare

DAY = 864e5

daystr = (date)=>date.toISOString().slice(0,10)

< (project, version, duration)=>
  [
    verSet
    ver_li
  ] = await verdb(project)

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

  dist = {}
  if alpha
    dist.alpha = version

  this_release = []
  for [i] from dist_ts
    # 首次发布
    if not release[i]
      dist[i] = version
      delete can_dist[i]
      this_release.push i

  for [channel, [pos, i]] from Object.entries can_dist
    if compare(release[channel], i[0]) < 0
      dist[channel] =  i[0]
      i[2].push channel
      ver_li[pos] = i[0]+' '+daystr(new Date(i[1]*DAY))+' '+i[2].join('|')

  txt =[
    version
    daystr(new Date)
  ]
  if this_release.length > 0
    txt.push this_release.join('|')

  ver_li.push txt.join(' ')

  return [
    release
    dist
    =>
      verSet(ver_li.join('\n'))
  ]
