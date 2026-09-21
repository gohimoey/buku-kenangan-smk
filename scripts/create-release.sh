#!/bin/bash
set -e

# Use PAT token for git operations
git remote set-url origin https://x-token-auth:${PAT_TOKEN}@github.com/${GITHUB_REPOSITORY}.git
git config user.email "actions@github.com"
git config user.name "GitHub Actions"

# Create tag
git tag "v${GITHUB_RUN_NUMBER}"
git push origin "v${GITHUB_RUN_NUMBER}"

echo "Tag v${GITHUB_RUN_NUMBER} created successfully"