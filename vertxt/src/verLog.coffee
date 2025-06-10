> ./set.js
  fs > existsSync
  @3-/write
  @3-/read

< (ver_yml, project, version)=>
  txt_li = if existsSync(ver_yml) then read(ver_yml).trim().split('\n') else []

  console.log Math.round new Date / 1000
  # txt_li.push version

  console.log {
    ver_yml
    project
    version
  }
  return
