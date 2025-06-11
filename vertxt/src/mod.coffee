#!/usr/bin/env coffee

> yargs
  yargs/helpers > hideBin
  ./verLog.js

argv = hideBin(process.argv)

yargs(argv).command(
  '$0 <ver_yml> <project> <ver> <duration>',
  '上传文件到指定项目和频道',
  (yargs) =>
    yargs
      .positional('ver_yml', {
        describe: '版本历史',
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
      .positional('duration', {
        describe: 'alpha → beta → stable 的时间间隔（单位：天）',
        type: 'integer'
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
