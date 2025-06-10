> @3-/vb/vbE.js

< (ver)=>
  Buffer.from(vbE(
    ver.split('.').map((i)=>Number.parseInt(i))
  )).toString('base64url')
