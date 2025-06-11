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
  if not r
    return [
      []
    ]
  conf.sha = r[1]
  return [
    r[0].trim().split('\n')
    saver conf
  ]
