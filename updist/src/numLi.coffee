#!/usr/bin/env coffee

<  (txt) =>
  li = []
  for i from txt.split(',')
    i = i.split('~')
    if i.length > 1
      [begin, end] = i
      n = +begin
      end = +end
      loop
        li.push ''+n
        if ++n > end
          break
    else
      li.push i[0]
  return li

