#!/usr/bin/env coffee

> @3-/cf
  @3-/cf/setTXT.js
  @3-/vb/vbE.js
  simple-zstd > ZSTDCompress
  path > basename join
  os > tmpdir
  tar > c:createTar
  crypto > createHash
  fs > readFileSync createReadStream createWriteStream existsSync unlinkSync mkdirSync rmdirSync writeFileSync
  yargs
  yargs/helpers > hideBin
  @noble/curves/ed25519 > ed25519ph

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

distTar = (project, version, channel, sk_fp, dir, filepath)=>
  key = readFileSync sk_fp
  stream = createReadStream filepath
  hash = createHash('sha3-512')
  ver_bin = Buffer.from vbE version.split('.').map (i)=>Number.parseInt(i)
  hash.update ver_bin

  ver_b64 = ver_bin.toString('base64url')
  new Promise(
    (resolve, reject)=>
      stream.on 'error', reject
      stream.on 'data', (chunk) =>
        hash.update(chunk)
        return
      stream.on 'end', =>
        hash = hash.digest()
        sign = ed25519ph.sign(
          hash
          key
        )
        writeFileSync(
          join dir, 'sign'
          sign
        )
        # console.log ed25519ph.verify(
        #   sign
        #   hash
        #   readFileSync(sk_fp.slice(0,-2)+'pk')
        # )
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

          rmdirSync dir, recursive:true, force:true
          resolve()
          return
        return
      return
  )

dist = (project, version, channel, sk_fp, dirpath)=>
  dir = join tmpdir(), basename(dirpath), version

  if existsSync dir
    rmdirSync dir, recursive:true, force:true

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

  await distTar project, version, channel, sk_fp, dir, tar
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
