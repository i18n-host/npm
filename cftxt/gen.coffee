#!/usr/bin/env coffee

> @noble/ed25519 > utils getPublicKey
  fs > writeFileSync

{argv} = process
name = argv.slice(2)[0]

if not name
  console.log 'usage: '+argv[1]+' <name>'
  process.exit(1)


sk = utils.randomPrivateKey()

writeFileSync(name+'.sk', sk)

pk = await getPublicKey Buffer.from(sk)
console.log pk
#   # 将公钥也转换为十六进制字符串
#   publicKeyHex = Buffer.from(publicKeyBytes).toString('hex')
#
#   # 将私钥和公钥保存到各自的文件中
#   fs.writeFileSync(privateKeyPath, privateKeyHex)
#   fs.writeFileSync(publicKeyPath, publicKeyHex)
#
#   console.log "✅ 密钥生成成功!"
#   console.log "🔑 私钥已保存到: #{privateKeyPath}"
#   console.log "📢 公钥已保存到: #{publicKeyPath}"
#
# .catch (error) ->
#   console.error "生成密钥时出错:", error
