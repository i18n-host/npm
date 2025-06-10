> ./set.js
  fs > existsSync
  @3-/write
  @3-/read

< (ver_yml, project, version)=>
  txt_li = if existsSync(ver_yml) then read(ver_yml) else []


  console.log {
    ver_yml
    project
    version
  }
  return
