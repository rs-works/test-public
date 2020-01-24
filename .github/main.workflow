# For issues

workflow "issues" {
  on       = "issues"
  resolves = ["Add an issue to project"]
}

action "Add an issue to project" {
  uses    = "docker://masutaka/github-actions-all-in-one-project"
  secrets = ["GITHUB_TOKEN"]
  args    = ["issue"]

  env = {
    PROJECT_URL         = "https://github.com/users/rs-works/projects/1" # required
    INITIAL_COLUMN_NAME = "Backlog"                                      # required. It is added to this column.
  }
}

# For pull requests

workflow "pull_requests" {
  on       = "pull_request"
  resolves = ["Add a pull_request to project"]
}

action "Add a pull_request to project" {
  uses    = "docker://masutaka/github-actions-all-in-one-project"
  secrets = ["GITHUB_TOKEN"]
  args    = ["pull_request"]

  env = {
    PROJECT_URL         = "https://github.com/users/rs-works/projects/1" # required
    INITIAL_COLUMN_NAME = "In progress"                                  # required. It is added to this column.
  }
}
