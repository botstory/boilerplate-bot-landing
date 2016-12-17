#!/usr/bin/env bash

set -e

ME=`basename "$0"`
SOURCE_PROJECT=boilerplate-bot-landing
SOURCE_BRANCH=develop

echo "|"
echo "| Download Boilerplate"
echo "|"

wget https://github.com/botstory/${SOURCE_PROJECT}/archive/${SOURCE_BRANCH}.zip

echo "|"
echo "| Unpack Boilerplate"
echo "|"

unzip ${SOURCE_BRANCH}.zip

echo "|"
echo "| Move to the project directory"
echo "|"

mv -v ${SOURCE_PROJECT}-${SOURCE_BRANCH}/{.[^.]*,*} .

echo "|"
echo "| Remove temporary files"
echo "|"

rm -drv ${SOURCE_BRANCH}.zip ${SOURCE_PROJECT}-${SOURCE_BRANCH} ${ME}

echo "|"
echo "| Enjoy!"
echo "|"
