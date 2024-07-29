#!/bin/bash

base_branch=$1

echo "Fetching from origin..."
git fetch --prune --all
echo "... done"

echo "Rebasing on branch \"$base_branch\"..."
git rebase $base_branch
rebase_exit_code=$?
echo "... done"

echo "Rebase exit code: $rebase_exit_code"

echo "Git status:"
git status

