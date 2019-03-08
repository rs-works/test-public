#!/bin/bash

# CIRCLE_PROJECT_USERNAME=rs-works
# CIRCLE_PROJECT_REPONAME=test-public
# GITHUB_ACCESS_TOKEN=rs-works:7ee4f25438e71c0988f4ec97eb735c08134663ff
# CIRCLE_SHA1=1e7ee91904958f9b76ebdb543dd1cc01a5d5dc53
# CIRCLE_BUILD_URL=https://circleci.com/gh/rs-works/test-public/13
# gh_deploy_id=133104486
echo gh_deploy_id = $gh_deploy_id

# Notify GitHub of a successful deployment
notify_gh_about_a_deployment () {
  declare -r deployment_id=${1}
  declare -r deployment_status=${2}
  curl -s -X POST "https://api.github.com/repos/${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}/deployments/${deployment_id}/statuses" \
    -H 'Content-Type: application/json' \
    -H 'Accept: application/vnd.github.ant-man-preview+json' \
    -u ${GITHUB_ACCESS_TOKEN} \
    -d "{\"state\": \"${deployment_status}\", \"log_url\": \"${CIRCLE_BUILD_URL}\"}"
}

# When a deploy is successful:
notify_gh_about_a_deployment $gh_deploy_id "success"
