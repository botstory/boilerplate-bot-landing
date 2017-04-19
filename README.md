# Boilerplate bot landing
[![Build Status](https://travis-ci.org/botstory/boilerplate-bot-landing.svg?branch=develop)](https://travis-ci.org/botstory/boilerplate-bot-landing)

Sources of landing page of
[Boilerplate bot](https://github.com/botstory/boilerplate-bot).

## Stack

- auto-deployment by
[travis ci](https://gist.github.com/domenic/ec8b0fc8ab45f39403dd)
- [bablejs](https://babeljs.io/)
- [scss](http://sass-lang.com/)
- [webpack v2](https://webpack.github.io/)

## Instruction

- download sources and unzip

```bash
bash <(curl -s https://raw.githubusercontent.com/botstory/boilerplate-bot-landing/develop/scripts/download-sources.sh)
```

Script will download boilerplate code in current directory.

:warning: script will remove all files from current directory which have
similar names as in boilerplate code. So please commit your changes 
before run boilerplate download script.

-- rename `boilerplate` to `<project-name>`

```bash
# MacOS
PROJECT_NAME=<project-name>
find . -type f ! -path "./.git/*" ! -path "*deploy_key*" -exec sed -i "" -e 's/boilerplate/${PROJECT_NAME}/g' {}  \;

#Linus
find . -type f ! -path "./.git/*" ! -path "*deploy_key*" -exec sed -i 's/boilerplate/${PROJECT_NAME}/g' {}  \;
```

- setup deploy

follow steps from [here](https://gist.github.com/domenic/ec8b0fc8ab45f39403dd#get-encrypted-credentials):
   - create `deploy_key`
     `ssh-keygen -t rsa -b 4096 -C "your_email@example.com"`
   - add it to the target repository
     `https://github.com/<your name>/<your repo>/settings/keys.`
   - encrypt it with Travis and get `encryption label`
     `travis encrypt-file deploy_key`
   - add `deploy_key.enc` to repository
     `git add deploy_key.enc`
   - update `.travis.yml` with `encryption label`
