#!/usr/bin/env coffee

import stylus from './lib/mod.js'

stylusCode = '''
a
  transform scale(0.5)
  xxx x
  xbbb:w
  appearance none
  &:hover
    color #fe4334
'''

console.log stylus stylusCode
