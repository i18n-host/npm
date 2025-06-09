#!/usr/bin/env coffee

> ./setTxt.js
  simple-zstd > ZSTDCompress
  path > basename join
  os > tmpdir
  tar > c:createTar
  fs > createWriteStream existsSync mkdirSync rmSync
  yargs
  yargs/helpers > hideBin
  ./distTar.js

dist = (project, version, channel, sk_fp, dirpath)=>
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


argv = hideBin(process.argv)

yargs(argv).command(
  '$0 <project> <ver> <channel> <key> <file>',
  '上传文件到指定项目和频道',
  (yargs) =>
    yargs
      .positional('project', {
        describe: '项目名称',
        type: 'string'
      })
      .positional('ver', {
        describe: '项目版本',
        type: 'string'
      })
      .positional('channel', {
        describe: '频道名称',
        type: 'string'
      })
      .positional('key', {
        describe: '私钥文件路径',
        type: 'string'
      })
      .positional('file', {
        describe: '要上传的文件路径',
        type: 'string'
      })
    return
  =>
    await dist ...argv
    process.exit(0)
    return
)
.help()
.alias('h', 'help')
.strict()
.argv



# https://github.com/up51/v
# https://
# github.com/i18n-site/rust/releases/download/i18n.site
# /0.2.104/x86_64-pc-windows-msvc.tar

# ver
# github.com/up51/v

# console.log await GET('?name=018007.xyz')
# // cf.get)
#
# // curl -X POST "https://api.cloudflare.com/client/v4/zones/<YOUR_ZONE_ID>/dns_records" \
# //      -H "Authorization: Bearer <YOUR_API_TOKEN>" \
# //      -H "Content-Type: application/json" \
# //      --data '{
# //        "type": "TXT",
# //        "name": "i18-nightly.i18-nightly",
# //        "content": "123",
# //        "ttl": 600,
# //        "proxied": false
# //      }'
