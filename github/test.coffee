#!/usr/bin/env coffee

import {ghGetTxt,ghSet} from './lib/mod.js'

conf = {
  owner:'i18n-host',
  repo:'i18',
  branch:'dev',
  path:'test.sh'
}

console.log await ghGetTxt conf

conf.path = 'xxx.yml'
conf.message = '-'
conf.content = Buffer.from(
  '123'
  'utf8'
).toString('base64')

await ghSet(
  conf
)
