#!/usr/bin/env coffee

> @3-/utf8/utf8d.js

import mincss from './lib/mod.js'

console.log utf8d (mincss(
  '''body{
  background: #ff000;
}'''
  'test.css',
  true
)).code
