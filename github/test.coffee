#!/usr/bin/env coffee

import {ghGetTxt,ghSet} from './lib/mod.js'

conf = {
  owner:'i18n-host',
  repo:'i18',
  branch:'dev',
  path:'test.sh'
}

console.log await ghGetTxt conf

# conf.sha = "a70488abd3734dd5566d19bb4ef022538f232376"
conf.path = 'ver.yml'
conf.message = 'goood'
conf.content = Buffer.from(
  '123zsdf'
  'utf8'
).toString('base64')
console.log conf
await ghSet(
  conf
)
