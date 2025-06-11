#!/usr/bin/env coffee

import { Octokit } from "@octokit/rest"

GH = new Octokit({
  auth: process.env.GITHUB_TOKEN
})

# { owner, repo, path, ref }
export ghGet = (conf)=>
  r = await GH.repos.getContent(conf)
  console.log r

export ghSet = (conf)=>
