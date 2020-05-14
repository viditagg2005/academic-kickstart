#!/bin/sh

# If a command fails then the deploy stops
set -e

# Removing public folder
rm -r public/
git rm -r --cached public

#initiate public folder
git submodule add -f -b master https://github.com/vlgiitr/vlgiitr.github.io.git public

printf "\033[0;32m Deploying updates to GitHub:\033[0m\n"

# pushing changes
git add .
git commit -m "Updated changes $(date)"
git push -u origin master

# Build the project.
hugo -t academic # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd public

printf "\033[0;32m Now in /public folder.\033[0m\n"

# Add changes to git.
printf "\033[0;32mChecking out master branch.\033[0m\n"
git checkout master
printf "\033[0;32mStaging changes.\033[0m\n"
git add .

# Commit changes.
printf "\033[0;32mCommitting.\033[0m\n"
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
printf "\033[0;32mPushing to GitHub.\033[0m\n"
git push origin master
