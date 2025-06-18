#!/usr/bin/env coffee

import down from './lib/releaseLs.js'

console.log await down(
  'up51'
  'i18'
  'dev'
)

# conf = {
#   owner:'up51',
#   repo:'i18',
#   # branch:'dev',
#   # path:'test.sh'
# }
#
# console.log await down conf

# conf.sha = "a70488abd3734dd5566d19bb4ef022538f232376"
# conf.path = 'Cargo.lock1'
# conf.owner = 'i18n-dev'
# conf.repo = 'ver'
# # conf.path = 'ver.yml'
# conf.message = 'goood2'
# conf.content = Buffer.from(
#   '123zsdf'
#   'utf8'
# ).toString('base64')
#
# await ghSet(
#   conf
# )
