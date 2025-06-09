#!/usr/bin/env coffee

> fs > writeFileSync mkdirSync
  crypto > generateKeyPairSync

{argv} = process
name = argv.slice(2)[0]

if not name
  console.log 'usage: '+argv[1]+' <name>'
  process.exit(1)

mkdirSync name, recursive: true


keys = generateKeyPairSync 'ed25519'

# 提取 DER 格式的二进制公钥和私钥
# PKCS8 格式用于私钥, SPKI 格式用于公钥
sk = keys.privateKey.export(
  type: 'pkcs8'
  format: 'der'
)
pk = keys.publicKey.export(
  type: 'spki'
  format: 'der'
)
writeFileSync(name+'/sk', sk)
writeFileSync(
  name+'/pk'
  pk
)
