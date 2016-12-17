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

## TODO

- download sources and unzip

```bash
$ bash <(curl -s https://raw.githubusercontent.com/botstory/boilerplate-bot-landing/feature/help/scripts/download-sources.sh)
```

Script will download boilerplate code in current directory.
:warning: script will remove all files from current directory which have
similar names as in boilerplate code. So please commit your changes 
before run boilerplate download script.
