#!/usr/bin/env coffee

> @3-/utf8/utf8d.js

import { Octokit } from "@octokit/rest"

export GH = new Octokit({
  auth: process.env.GITHUB_TOKEN
})

# { owner, repo, path, ref }
export ghGet = (conf)=>
  try
    r = await GH.repos.getContent(conf)
  catch err
    if err.response.status == 404
      return
    throw err
  return Buffer.from r.data.content,'base64'

export ghGetTxt = (conf)=>
  r = await ghGet(conf)
  if r
    r = utf8d r
  return r

export ghSet = (conf)=>
  GH.repos.createOrUpdateFileContents(conf)
