#!/usr/bin/env coffee

> yargs
  yargs/helpers > hideBin

argv = hideBin(process.argv)

yargs(argv).command(
  '$0 <ver_yml> <project> <ver>',
  '上传文件到指定项目和频道',
  (yargs) =>
    yargs
      .positional('ver_yml', {
        describe: '版本日志',
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
    await verLog ...argv
    process.exit(0)
    return
)
.help()
.alias('h', 'help')
.strict()
.argv
