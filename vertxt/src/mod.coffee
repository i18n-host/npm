#!/usr/bin/env coffee

> @3-/cf
  @3-/cf/setTXT.js
  yargs
  yargs/helpers > hideBin
  @3-/verb64/verb64E.js

{GET, POST, DELETE} = cf
{
  TXT_HOST_LI
  DOWN_HOST_LI
  GITHUB_OWNER
  GITHUB_REPO
} = process.env
TXT_HOST_LI = TXT_HOST_LI.split(' ')

SET_TXT = ";G#{GITHUB_OWNER}/#{GITHUB_REPO};"+DOWN_HOST_LI

set = (channel, project, version)=>
  verb64 = verb64E version
  txt = verb64 + SET_TXT
  # [
  #   project
  #   channel
  # ] = process.argv.slice(2)

  console.log project, version, txt, channel
  # zone_id_li = (await Promise.all(
  #   HOST_LI.map (i)=>GET('?name='+i)
  # )).map ([i])=>i.id
  #
  # content = JSON.stringify(txt)
  # await Promise.allSettled HOST_LI.map (host, pos)=>
  #   setTXT(
  #     project+'-'+channel
  #     host
  #     zone_id_li[pos]
  #     content
  #   )
  return


argv = hideBin(process.argv)

yargs(argv).command(
  '$0 <channel> <project> <ver>',
  '上传文件到指定项目和频道',
  (yargs) =>
    yargs
      .positional('channel', {
        describe: '发布的频道 alpha/beta/stable',
        type: 'string'
      })
      .positional('project', {
        describe: '项目名称',
        type: 'string'
      })
      .positional('ver', {
        describe: '项目版本',
        type: 'string'
      })
    return
  =>
    await set ...argv
    process.exit(0)
    return
)
.help()
.alias('h', 'help')
.strict()
.argv
