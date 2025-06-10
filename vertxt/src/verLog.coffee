> ./set.js
  fs > existsSync
  @3-/write
  @3-/read
  semver > compare

< (ver_yml, project, version)=>
  exist = new Set
  ver_txt = if existsSync(ver_yml) then read(ver_yml).trim() else ''
  txt_li =  ver_txt.split('\n').filter(
    (i)=>not i.startsWith('#')
  ).map(
    (i)=>
      i = i.split(' ')
      exist.add i[0]
      i
  )

  if exist.has version
    return

  txt_li.sort (a,b)=>
    compare(a[0],b[0])

  if compare(txt_li.at(-1)[0], version) < 0
    await set 'alpha', project, version

  ver_txt += "\n#{version} #{(new Date).toISOString().slice(0,16)}"
  write(ver_yml, ver_txt)

  return
