#!/usr/bin/env coffee

> ./verdb.js
  semver > compare

DAY = 864e5

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

  return [
    verSet
    release
    alpha
  ]
