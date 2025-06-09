#!/usr/bin/env coffee

> fs > createReadStream
  path > basename
  @octokit/rest > Octokit

{
  GITHUB_TOKEN
} = process.env

export default (owner, repo_name, project, ver, file)=>
  tag = project + '-' + ver
  gh = new Octokit({ auth: GITHUB_TOKEN })
  release = await gh.repos.getReleaseByTag(owner, repo_name, tag)
  console.log release
  # console.log owner, repo_name
  # li = (await repo.listReleases()).data
  #
  # + id
  # for i in li
  #   if i.tag_name == tag
  #     {id} = i
  #     break
  # if not id
  #   {
  #     id
  #   } = await repo.createRelease({
  #     tag_name: tag
  #     name: tag
  #     body: '-'
  #   })
  #
  # console.log await repo.uploadAsset(
  #   id
  #   {
  #     name: basename file
  #     file: createReadStream(file)
  #   }
  # )
  return



