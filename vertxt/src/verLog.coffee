> ./set.js
  fs > existsSync
  @3-/write
  @3-/read
  semver > compare

< (ver_yml, project, version)=>
  ver_txt = if existsSync(ver_yml) then read(ver_yml).trim() else ''
  txt_li =  ver_txt.split('\n').filter(
    (i)=>not i.startsWith('#')
  ).map(
    (i)=>
      i.split(' ')
  )

  txt_li.sort (a,b)=>
    compare(a[0],b[0])


  ver_txt += "\n#{version} #{(new Date).toISOString().slice(0,16)}"

  write(ver_yml, ver_txt)

  console.log {
    ver_yml
    project
    version
  }
  return
