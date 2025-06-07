[Github Repo](https://github.com/i18n-host/npm/tree/dev/stylus)

stylus to css with support [css nesting](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_nesting)

```coffee
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
```

output:

```css
a{
  transform: scale(0.5);
  xxx: x;
  xbbb:w;
  -webkit-appearance: none;
     -moz-appearance: none;
          appearance: none;
  &:hover{
    color: #fe4334}}
```
