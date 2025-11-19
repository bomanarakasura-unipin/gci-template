#!/bin/bash

# Exit on error
set -e

kebab_to_pascal() {
  local input="$1"

  echo "$input" | sed -r 's/(^|-)([a-z])/\U\2/g'
}

extract_gci_parent_name() {
  local input="$1"

  echo "$input" | sed -r 's/ms-gci-//'
}

create_package_name() {
  local input="$1"

  echo "$input" | sed -r 's/-//g'
}

main() {
  echo "Starting to initiating GCI project..."

  # Get repositoryu name
  REPO_NAME="${GITHUB_REPOSITORY##*/}"

  # Create all string replacement
  local package_name=$(create_package_name "$REPO_NAME")
  local parent_name=$(extract_gci_parent_name "$REPO_NAME")
  local integration_name=$(kebab_to_pascal "$parent_name")

  echo "Package name : $package_name"
  echo "Parent name : $parent_name"
  echo "Integration name : $integration_name"

  # Renaming directory
  # Sort in reverse order to avoind renaming parent name before children
  find . -type d -name "*gci-parent-name*" ! -path "./git/*" | sort -r | while read -r dir; do
    # Get parent directory
    parent=$(dirname "$dir")
    # Get folder name
    foldername=$(basename "$dir")

    # Replace dir name
    new_foldername=${foldername//"gci-parent-name"/"$integration_name"}
    new_dir="$parent/$new_foldername"

    if [ "$dir" != "$new_path" ]; then
      echo "Renaming directory $dir => $new_dir"

      # mv "$dir" "$new_dir"
    fi
  done
}

main
