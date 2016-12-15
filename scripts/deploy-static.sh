#!/bin/bash

#
#
# based on https://gist.github.com/domenic/ec8b0fc8ab45f39403dd
#
#

set -e # Exit with nonzero exit code if anything fails

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TARGET_BRANCH="gh-pages"

function doCompile {
  ${DIR}/compile-static.sh
}

# Content of this directory will be deployed
mkdir -p dist

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
#if [ "${TRAVIS_PULL_REQUEST}" != "false" ]; then
#    echo "Skipping deploy of pull request; just doing a build."
#    # Clean out existing contents
#    doCompile
#    exit 0
#fi

# Save some useful information
DEFAULT_REPO=`git config remote.origin.url`
REPO="${REPO:-${DEFAULT_REPO}}"
SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}
SHA=`git rev-parse --verify HEAD`

echo "clone repository ${REPO}"

# Clone the existing gh-pages for this repo into dist/
# Create a new empty branch if gh-pages doesn't exist yet (should only happen on first deploy)

git clone ${REPO} dist
cd dist
git checkout ${TARGET_BRANCH} || git checkout --orphan ${TARGET_BRANCH}
cd ..

# Clean out existing contents
rm -rf dist/**/* || exit 0

# Run our compile script
doCompile

# Now let's go have some fun with the cloned repo
cd dist
git config user.name "Travis CI"
git config user.email "${COMMIT_AUTHOR_EMAIL}"

# If there are no changes to the compiled out (e.g. this is a README update) then just bail.
# improved by @adbre
if [ $(git status --porcelain | wc -l) -lt 1 ]; then
    echo "No changes to the output on this push; exiting."
    exit 0
fi

if [ "${TRAVIS_TAG}" = "" ]
then
   COMMIT_TITLE="Deploy to GitHub Pages: ${SHA}"
else
   COMMIT_TITLE="Deploy to GitHub Pages: ${TRAVIS_TAG}"
fi

# Commit the "changes", i.e. the new version.
# The delta will show diffs between new and old versions.

echo "Adding..."

git add -A .
git commit -m "${COMMIT_TITLE}"

echo "Signing..."

# Get the deploy key by using Travis's stored variables to decrypt deploy_key.enc
ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}
openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in ../deploy_key.enc -out deploy_key -d
chmod 600 deploy_key
eval `ssh-agent -s`
ssh-add deploy_key

echo "Deploying..."

# Now that we're all set up, we can push.
git push $SSH_REPO $TARGET_BRANCH
