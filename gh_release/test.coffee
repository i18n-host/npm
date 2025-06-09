#!/usr/bin/env coffee

import gh_release from './src/mod.coffee'

await gh_release(
  'up51'
  'v'
  'i18'
  '0.1.2'
  '/tmp/0.2.1.tar'
)
console.log 'done'
