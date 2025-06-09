#!/usr/bin/env coffee

> @3-/cf
  @3-/cf/setTXT.js
  @3-/vb/vbE.js
  simple-zstd > ZSTDCompress
  path > basename join
  os > tmpdir
  tar > c:createTar
  fs > readFileSync createReadStream createWriteStream existsSync unlinkSync mkdirSync rmSync writeFileSync
  yargs
  yargs/helpers > hideBin
  @3-/ed25519_ph:Ed25519

{GET, POST, DELETE} = cf

setTxt = (project, channel, txt)=>
  # [
  #   project
  #   channel
  # ] = process.argv.slice(2)
  {HOST_LI} = process.env
  HOST_LI = HOST_LI.split(' ')

  zone_id_li = (await Promise.all(
    HOST_LI.map (i)=>GET('?name='+i)
  )).map ([i])=>i.id

  content = JSON.stringify(txt)
  await Promise.allSettled HOST_LI.map (host, pos)=>
    setTXT(
      project+'-'+channel
      host
      zone_id_li[pos]
      content
    )
  return

distTar = (project, version, channel, sk_fp, platform, dir, filepath)=>
  stream = createReadStream filepath
  ver_bin = Buffer.from vbE version.split('.').map (i)=>Number.parseInt(i)
  ed25519 = Ed25519 readFileSync sk_fp
  ed25519.update ver_bin

  ver_b64 = ver_bin.toString('base64url')
  new Promise(
    (resolve, reject)=>
      stream.on 'error', reject
      stream.on 'data', (chunk) =>
        ed25519.update(chunk)
        return
      stream.on 'end', =>
        sign = ed25519.finish()
        writeFileSync(
          join dir, 'sign'
          sign
        )
        out_tar = dir+'.tar'
        if existsSync out_tar
          unlinkSync out_tar
        s = createWriteStream(out_tar)
        createTar(
          {
            cwd: dir
            portable: true,
            preservePaths: true
          }
          ['.']
        ).pipe s
        s.on 'finish', =>
          console.log out_tar
          rmSync dir, recursive:true, force:true
          resolve()
          return
        return
      return
  )

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
