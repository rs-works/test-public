#!/bin/bash

environment=dev

# Create a deployment
create_gh_deployment () {
  curl -s -X POST "https://api.github.com/repos/${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}/deployments" \
      -H 'Content-Type: application/json' \
      -H 'Accept: application/vnd.github.ant-man-preview+json' \
      -u ${GITHUB_ACCESS_TOKEN} \
      -d "{\"ref\": \"${CIRCLE_SHA1}\", \"environment\": \"${environment}\", \"required_contexts\": [], \"auto_merge\": false}"
}

# Run this function when you trigger a deploy.
# Keep track of the deployment id as $gh_deploy_id for later. We're using https://stedolan.github.io/jq/ to parse the JSON to grab the id.
declare -r created_gh_deployment=$(create_gh_deployment)
echo $created_gh_deployment | jq .

declare -r gh_deploy_id=$(echo $created_gh_deployment | jq .id)

## deploy
sleep 3

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
