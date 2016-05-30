#!/usr/bin/env bash

set -e

git checkout master
FOLDER=$TMPDIR$RANDOM
VERSION=$(cat package.json | sed -n "s/ *\"version\": *\"\(.*\)\",/\1/p")

echo
echo You are going to publish the version $VERSION
read -p "Are you sure (y/n)? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

grunt

cd ../kmerhi.github.io
git checkout
rm -rf dist
mv ../jenkins-material-theme/dist ./dist

git add dist/
git commit -m "version $VERSION"
git push

git checkout master
