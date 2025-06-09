#!/usr/bin/env coffee

import gh_release from './src/mod.coffee'

await gh_release(
  'up51'
  'v'
  'i18'
  '0.1.2'
  import.meta.dirname + '/test.coffee'
)
console.log 'done'
