#!/usr/bin/env bash
npm install -g aglio
rm index.apib
cat documents/header.apib >> index.apib
cat documents/pages/*.apib >> index.apib
aglio -i index.apib --theme-template triple -o index.html

git config --global user.email "zarinpal@Travis"
git config --global user.name "zarinpal@Travis"
git config --global push.default simple
eval "$(ssh-agent -s)" #start the ssh agent
chmod 600 .deploy_key # this key should have push access
ssh-add .deploy_key
git clone -b gh-pages git@github.com:ZarinPal-Lab/API-Docs.git API-Docs
cp index.html API-Docs/index.html
cd API-Docs
git add --all
git commit -m "Travis CI"
git push