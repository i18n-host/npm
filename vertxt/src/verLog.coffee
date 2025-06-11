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
  beta_ts = now_ts - 10
  stable_ts = now_ts - 20

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

    i[1] = Math.round new Date(date) / 1e3
    if dist
      for j from dist.split('|')
        t = release[j]
        if not t
          release[j] = t = []
        t.push i


  if exist.has version
    return

  if alpha
    await set 'alpha', project, version

  # if ver_li.length > 0
  #   ver_li.sort (a,b)=>
  #     compare(a[0],b[0])
  #
  #   if compare(ver_li.at(-1)[0], version) < 0
  #
  # console.log ver_li

  ver_li.push "#{version} #{(new Date).toISOString().slice(0,10)}"
  write(ver_yml, ver_li.join('\n'))

  return
