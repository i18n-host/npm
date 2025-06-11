> @3-/github > ghGetTxt ghSet

{
  GITHUB_OWNER
  GITHUB_REPO
} = process.env

saver = (conf)=>
  (txt)=>
    conf.message = '-'
    conf.content = Buffer.from(
      txt
      'utf8'
    ).toString('base64')
    ghSet conf

< verLi = (project)=>
  conf = {
    owner: GITHUB_OWNER
    repo: GITHUB_REPO
    path: project+'.yml'
  }
  r = await ghGetTxt conf

  result = [
    saver(conf)
  ]
  if r
    conf.sha = r[1]
    result.push [
      r[0].trim().split('\n')
    ]
  else
    result.push []
  result
