#!/usr/bin/env coffee

import {GH,ghGetTxt,ghSet} from './lib/mod.js'

conf = {
  owner:'i18n-host',
  repo:'i18',
  # branch:'dev',
  path:'test.sh'
}

console.log await ghGetTxt conf

# conf.sha = "a70488abd3734dd5566d19bb4ef022538f232376"
conf.path = 'Cargo.lock1'
# conf.path = 'ver.yml'
conf.message = 'goood'
conf.content = Buffer.from(
  '123zsdf'
  'utf8'
).toString('base64')
# conf.headers =   {
#     'X-GitHub-Api-Version': '2022-11-28'
#   }

console.log conf
# await ghSet(
#   conf
# )
console.log await GH.request('PUT /repos/i18n-host/i18/contents/'+conf.path, conf)

# {
#   owner: 'OWNER',
#   repo: 'REPO',
#   path: 'PATH',
#   message: 'my commit message',
#   committer: {
#     name: 'Monalisa Octocat',
#     email: 'octocat@github.com'
#   },
#   content: 'bXkgbmV3IGZpbGUgY29udGVudHM=',
#   headers: {
#     'X-GitHub-Api-Version': '2022-11-28'
#   }
# })
