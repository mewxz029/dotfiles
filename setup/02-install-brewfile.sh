#!/usr/bin/env bash

DIR_BREWFILE="$HOME/Brewfile"

if [ -e $DIR_BREWFILE ]
then
  echo $DIR_BREWFILE
  echo "🟣 installing brewfile"

  yes | brew bundle install --file=$DIR_BREWFILE

  echo "✅ brewfile installed!"
  exit 0
fi

echo "🟣 skipped brewfile."
