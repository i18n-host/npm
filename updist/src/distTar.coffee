> @3-/vb/vbE.js
  @3-/ed25519_ph:Ed25519
  fs > readFileSync createReadStream createWriteStream existsSync unlinkSync rmSync writeFileSync
  tar > c:createTar
  path > join
  @3-/gh_release:ghRelease
  ./s3put.js

{
  GITHUB_TOKEN
  GITHUB_OWNER
  GITHUB_REPO
} = process.env

export default (project, version, sk_fp, dir, filepath)=>
  stream = createReadStream filepath
  ver_bin = Buffer.from vbE version.split('.').map (i)=>Number.parseInt(i)
  ed25519 = Ed25519 readFileSync sk_fp
  ed25519.update ver_bin

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
          Promise.all([
            # s3put(
            #   project
            #   version
            #   out_tar
            # )
            # ghRelease(
            #   GITHUB_TOKEN
            #   GITHUB_OWNER
            #   GITHUB_REPO
            #   project
            #   version
            #   out_tar
            # )
          ]).finally =>
            try
              console.log '>>>', project, version, out_tar
            catch err
              reject err
              return
            rmSync dir, recursive:true, force:true
            resolve()
            return
          return
        return
      return
  )
