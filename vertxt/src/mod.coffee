#!/usr/bin/env coffee

> @3-/cf
  @3-/cf/setTXT.js
  yargs
  yargs/helpers > hideBin

{GET, POST, DELETE} = cf
{HOST_LI} = process.env
HOST_LI = HOST_LI.split(' ')

set = (project, version, channel)=>
  # [
  #   project
  #   channel
  # ] = process.argv.slice(2)

  console.log project, version, channel
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
  '$0 <project> <ver> <channel>',
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
        describe: '发布的频道 alpha/beta/stable',
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
