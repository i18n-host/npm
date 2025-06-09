> @3-/vb/vbE.js
  @3-/ed25519_ph:Ed25519
  fs > readFileSync createReadStream createWriteStream existsSync unlinkSync rmSync writeFileSync
  tar > c:createTar
  path > join


{
  GITHUB_OWNER
  GITHUB_REPO
  GITHUB_TOKEN
} = process.env

export default (project, version, channel, sk_fp, platform, dir, filepath)=>
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
