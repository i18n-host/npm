#!/usr/bin/env coffee

> simple-zstd > ZSTDCompress
  path > basename join
  os > tmpdir
  tar > c:createTar
  fs > createWriteStream existsSync mkdirSync rmSync
  ./distTar.js

export default (project, version, channel, sk_fp, dirpath)=>
  platform = basename(dirpath)
  dir = join tmpdir(), project, version, platform

  if existsSync dir
    rmSync dir, recursive:true, force:true

  mkdirSync dir,recursive:true

  tar = join dir, 'tar.zst'

  s = createWriteStream(tar)

  createTar(
    {
      cwd: dirpath
      portable: true,
      preservePaths: true
    }
    ['.']
  )
    .pipe(ZSTDCompress(19))
    .pipe s

  await new Promise (resolve, reject)=>
    s.on 'finish', resolve
    s.on 'error', reject
    return

  await distTar project, version, channel, sk_fp, platform, dir, tar
  return
