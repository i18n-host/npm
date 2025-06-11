> ./set.js
  fs > existsSync
  @3-/write
  @3-/read
  semver > compare

< (ver_yml, project, version)=>
  ver_li = if existsSync(ver_yml) then read(ver_yml).trim().split('\n') else []

  release = {}

  now_ts = new Date / 1e3

  beta = now_ts - 864e3

  dist_ts = Object.entries {
    beta
    stable: beta - 864e3
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

    i[1] = ts = Math.round new Date(date) / 1e3

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
        if pre
          console.log 'TODO'
        else
          can_dist[channel] = [pos, i]

  txt =[
    version
    (new Date).toISOString().slice(0,10)
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

  console.log can_dist

  ver_li.push txt.join(' ')
  write(ver_yml, ver_li.join('\n'))

  return
