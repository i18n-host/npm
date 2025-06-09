#!/usr/bin/env coffee

> @noble/ed25519 > utils getPublicKeyAsync
  fs > writeFileSync mkdirSync

{argv} = process
name = argv.slice(2)[0]

if not name
  console.log 'usage: '+argv[1]+' <name>'
  process.exit(1)

mkdirSync name, recursive: true

sk = utils.randomPrivateKey()

writeFileSync(name+'/sk', sk)

writeFileSync(
  name+'/pk'
  await getPublicKeyAsync sk
)
