#!/usr/bin/env coffee

import {ghGet,ghSet} from './lib/mod.js'

console.log await ghGet {
  owner:'i18n-host',
  repo:'i18',
  branch:'dev',
  path:'test.sh'
}

