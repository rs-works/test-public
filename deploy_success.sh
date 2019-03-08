#!/bin/bash

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
# CIRCLE_PROJECT_USERNAME=rs-works
# CIRCLE_PROJECT_REPONAME=test-public
# GITHUB_ACCESS_TOKEN=rs-works:e70ae351f3d587c9d2676dd37d9c6e752d4515f1
# CIRCLE_SHA1=75da97ddc1380c369565292fe9b19f0d7dd9e72d
# CIRCLE_BUILD_URL=https://circleci.com/gh/rs-works/test-public/6
# gh_deploy_id=133098781
echo gh_deploy_id = $gh_deploy_id
notify_gh_about_a_deployment $gh_deploy_id "success"
