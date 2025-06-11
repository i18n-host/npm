> ./set.js
  fs > existsSync
  @3-/write
  @3-/read
  semver > compare

< (ver_yml, project, version)=>
  ver_li = if existsSync(ver_yml) then read(ver_yml).trim().split('\n') else []

  release = {}
  exist = new Set

  max_ver = 0

  for i,pos in ver_li
    i = i.trim()
    if not i or i.startsWith('#')
      continue
    i = i.split(' ')
    i[1] = Math.round new Date(i[1]) / 1e3
    if i[2]
      for j from i[2].split('|')
        t = release[j]
        if not t
          release[j] = t = []
        t.push i

    exist.add i[0]

  if exist.has version
    return
  #
  # if ver_li.length > 0
  #   ver_li.sort (a,b)=>
  #     compare(a[0],b[0])
  #
  #   if compare(ver_li.at(-1)[0], version) < 0
  #     await set 'alpha', project, version
  #
  # console.log ver_li
  #
  ver_li.push "#{version} #{(new Date).toISOString().slice(0,10)}"
  write(ver_yml, ver_li.join('\n'))

  return
