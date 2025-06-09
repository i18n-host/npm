#!/usr/bin/env coffee

> fs > writeFileSync mkdirSync
  crypto > generateKeyPairSync

{argv} = process
name = argv.slice(2)[0]

if not name
  console.log 'usage: '+argv[1]+' <name>'
  process.exit(1)

ed25519 = 'ed25519'

outdir=ed25519+'/'+name
mkdirSync outdir, recursive: true
outdir += '/'

keys = generateKeyPairSync ed25519

sk = keys.privateKey.export(
  type: 'pkcs8'
  format: 'der'
)
pk = keys.publicKey.export(
  type: 'spki'
  format: 'der'
)

writeFileSync(outdir+'sk', sk)

writeFileSync(
  outdir+'pk'
  pk
)
