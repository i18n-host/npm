> ./set.js
  fs > existsSync
  @3-/write
  @3-/read

< (ver_yml, project, version)=>
  txt_li = if existsSync(ver_yml) then read(ver_yml).trim().split('\n').filter(
    (i)=>not i.startsWith('#')
  ) else []

  console.log "#{version} #{(new Date).toISOString().slice(0,16)}"
  # txt_li.push version

  console.log {
    ver_yml
    project
    version
  }
  return
