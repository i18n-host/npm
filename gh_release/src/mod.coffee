#!/usr/bin/env coffee

> fs > createReadStream statSync
  path > basename
  @octokit/rest > Octokit

{
  GITHUB_TOKEN
} = process.env

export default (owner, repo, project, ver, file)=>
  tag = project + '-' + ver
  gh = new Octokit({ auth: GITHUB_TOKEN })
  try
    {id: release_id} = (await gh.repos.getReleaseByTag({
      owner, repo, tag
    })).data
  catch err
    if err.status != 404
      throw err

  if not release_id
    {id: release_id} = (
      await gh.repos.createRelease({
        owner
        repo
        tag_name: tag
        name: tag
        body: '…'
      })
    ).data
  filename = basename file
  try
    await gh.repos.uploadReleaseAsset({
      owner
      repo
      release_id
      name: filename
      headers: {
        'content-type': 'application/octet-stream'
        'content-length': statSync(file).size
      }
      data: createReadStream(file)
    })
  catch err
    errors = err?.response?.data?.errors
    if errors?.length == 1
      {code} = errors[0]
      if code == 'already_exists'
        console.log filename, code
        return
    throw err
  return




