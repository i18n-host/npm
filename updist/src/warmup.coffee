#!/usr/bin/env coffee

{DOWN_HOST_LI} = process.env

project = "i18"
ver = "1.2.3"
platform = "x86_64-unknown-linux-musl"

url_li = []

for i in DOWN_HOST_LI.split(';')
  first_char = i.charAt(0)

  if first_char >= 'A' and first_char <= 'Z'
    continue

  m = i.match /^(.*)\[(\d+)-(\d+)\](.*)$/
  if m
    [_, prefix, begin, end, remain] = m
    begin = +begin
    end = +end
    for i in [begin..end]
      url_li.push "#{prefix}#{i}#{remain}"
  else
    url_li.push "#{i}"

console.log url_li.map (i)=>
  "https://#{i}/#{project}/#{ver}/#{platform}.tar"
