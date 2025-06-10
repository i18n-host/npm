#!/usr/bin/env coffee

import verb64E from './src/verb64E.coffee'
import verb64D from './src/verb64D.coffee'

ver = verb64E('15.2.3')
console.log ver
console.log verb64D(ver)

