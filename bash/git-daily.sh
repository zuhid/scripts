#!/bin/bash

clear
projectList=(
  "api-cs"
  "scripts"
)
for project in "${projectList[@]}"; do
  echo $project
  # git clone "git@github.com:zuhid/$project" # clone the repo
  git -C $project branch # list local branches
  git -C $project remote prune origin # remove local branches which were deleted from origin
  git -C $project pull --quiet # pull the latest
  echo
done

echo "Done..."
sleep 2s
