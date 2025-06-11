> ./set.js
  fs > existsSync
  @3-/write
  @3-/read
  semver > compare

< (ver_yml, project, version)=>
  exist = new Set
  ver_txt = if existsSync(ver_yml) then read(ver_yml).trim() else ''
  ver_li =  ver_txt.split('\n').filter(
    (i)=>not i.startsWith('#')
  ).map(
    (i)=>
      i = i.split(' ')
      i[1] = Math.round new Date(i[1]) / 1e3
      exist.add i[0]
      i
  )

  if exist.has version
    return

  ver_li.sort (a,b)=>
    compare(a[0],b[0])

  if compare(ver_li.at(-1)[0], version) < 0
    await set 'alpha', project, version

  console.log ver_li

  ver_txt += "\n#{version} #{(new Date).toISOString().slice(0,16)}"
  write(ver_yml, ver_txt)

  return
