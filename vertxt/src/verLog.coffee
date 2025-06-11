> ./set.js
  fs > existsSync
  @3-/write
  @3-/read
  semver > compare

< (ver_yml, project, version)=>
  ver_li = if existsSync(ver_yml) then read(ver_yml).trim().split('\n') else []

  release = {}
  exist = new Set

  now_ts = new Date / 1e3
  beta_ts = now_ts - 864e3
  stable_ts = now_ts - 864e3*2

  alpha = 1

  for i,pos in ver_li
    i = i.trim()
    if not i or i.startsWith('#')
      continue
    i = i.split(' ')

    [ver, date, dist] = i
    exist.add ver

    switch compare(ver, version)
      when 0
        return
      when 1
        alpha = 0

    i[1] = ts = Math.round new Date(date) / 1e3

    if dist
      dist = dist.split('|')
      i[2] = dist
      for j from dist
        t = release[j]
        if t
          if compare(t, ver) < 0
            release[j] = ver
        else
          release[j] = ver

    if ts < stable_ts
      console.log i
    if ts < beta_ts
      console.log i

  if exist.has version
    return

  txt =[
    version
    (new Date).toISOString().slice(0,10)
  ]

  this_release = []
  if alpha
    await set 'alpha', project, version

  for i from ['beta', 'stable']
    if not release[i]
      await set i, project, version
      this_release.push i
  if this_release.length > 0
    txt.push this_release.join('|')

  for [channel, li] from Object.entries release
    console.log channel, li
  # if ver_li.length > 0
  #   ver_li.sort (a,b)=>
  #     compare(a[0],b[0])
  #
  #   if compare(ver_li.at(-1)[0], version) < 0
  #
  # console.log ver_li

  ver_li.push txt.join(' ')
  write(ver_yml, ver_li.join('\n'))

  return
