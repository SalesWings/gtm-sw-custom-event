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

changenote="$1"

# File path of the YAML file
yaml_file="metadata.yaml"

# Get the SHA of the latest commit (HEAD)
sha=$(git rev-parse HEAD)

# Check if the YAML file exists
if [[ ! -f $yaml_file ]]; then
  echo "Error: YAML file '$yaml_file' not found!"
  exit 1
fi

# Use yq to add the new entry to the top of the "versions" array
yq eval ".versions = [{\"sha\":\"$sha\",\"changeNotes\":\"$changenote\"}] + .versions" "$yaml_file" -i

echo "New entry with SHA '$sha' added to the YAML file."

# Stage and commit the changes
git add "$yaml_file"
git commit -m "Release version $sha"

echo "Changes committed with message: 'Release version $sha'."
