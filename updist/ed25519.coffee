#!/usr/bin/env coffee

import { ed25519ph } from '@noble/curves/ed25519'

> fs > writeFileSync mkdirSync

{argv} = process
name = argv.slice(2)[0]

if not name
  console.log 'usage: '+argv[1]+' <name>'
  process.exit(1)

ed25519 = 'ed25519'

outdir=ed25519+'/'+name
mkdirSync outdir, recursive: true
outdir += '/'

sk = ed25519ph.utils.randomPrivateKey()
writeFileSync(outdir+'sk', sk)

writeFileSync(
  outdir+'pk'
  ed25519ph.getPublicKey(sk)
)
