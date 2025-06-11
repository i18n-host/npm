#!/usr/bin/env coffee

import {ghGetTxt,ghSet} from './lib/mod.js'

console.log await ghGetTxt {
  owner:'i18n-host',
  repo:'i18',
  branch:'dev',
  path:'test.sh'
}

