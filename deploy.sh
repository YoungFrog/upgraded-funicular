#!/usr/bin/env sh

# build
npm run build || exit 1

# navigate into the build output directory
cd dist || exit 1

# if you are deploying to a custom domain
# echo 'www.example.com' > CNAME

git init &&
git add -A &&
git commit -m 'deploy' || exit 1

# if you are deploying to https://<USERNAME>.github.io
# git push -f git@github.com:<USERNAME>/<USERNAME>.github.io.git master

# if you are deploying to https://<USERNAME>.github.io/<REPO>
git push -f git@github.com:YoungFrog/upgraded-funicular.git master:gh-pages
