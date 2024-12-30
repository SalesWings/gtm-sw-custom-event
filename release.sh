#!/bin/bash

# Check if yq is installed and in PATH
if ! command -v yq &>/dev/null; then
  echo "Error: 'yq' is not installed or not in PATH. Please install 'yq' to use this script."
  exit 1
fi

# Check if changeNotes is provided as the first argument
if [[ -z "$1" ]]; then
  echo "Error: Change notes must be provided as the first argument."
  echo "Usage: $0 <Change notes>"
  exit 1
fi

# Ensure the current branch is 'main'
current_branch=$(git rev-parse --abbrev-ref HEAD)
if [[ "$current_branch" != "main" ]]; then
  echo "Error: You must be on the 'main' branch to run this script. Current branch: $current_branch"
  exit 1
fi

# Get the SHA of the latest commit (HEAD)
sha=$(git rev-parse HEAD)

# Create a new branch for the release
release_branch="release-$sha"
git pull
git checkout -b "$release_branch"

changenote="$1"

# File path of the YAML file
yaml_file="metadata.yaml"

# Use yq to add the new entry to the top of the "versions" array
yq eval ".versions = [{\"sha\":\"$sha\",\"changeNotes\":\"$changenote\"}] + .versions" "$yaml_file" -i

echo "New entry with SHA '$sha' added to the YAML file."

# Stage and commit the changes
git add "$yaml_file"
git commit -m "Release version $sha"

# Push the branch to origin
git push -u origin "$release_branch"

# Open the PR URL in the default browser
pr_url="https://github.com/SalesWings/gtm-sw-custom-event/pull/new/$release_branch"
echo "Opening PR URL in the browser: $pr_url"
if command -v xdg-open &>/dev/null; then
  xdg-open "$pr_url"
elif command -v open &>/dev/null; then
  open "$pr_url"
else
  echo "Please open this URL manually: $pr_url"
fi

echo "Branch '$release_branch' created, committed, pushed, and PR URL opened."
