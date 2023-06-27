#! /bin/bash

git init
rm -rf lib
forge install foundry-rs/forge-std --no-commit
git add --all
git commit -m "initial commit"

echo -e "\n\n"
echo "The test.sol repo is ready. You must add your own remote (git remote add git@github.com:...) in order for 'act' to work properly"
