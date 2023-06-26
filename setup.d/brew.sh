#!/bin/bash

ZPROFILE_PATH=${ZDOTDIR%/}/.zprofile

echo "--- Set up homebrew ---"
u=$(uname -s)
if [[ "$(uname)" != "Darwin" && "${u:0:5}" != "Linux" ]]; then
  echo "Skipped because homebrew cannot be installed on non-linuxOS or MacOS."
  exit
fi

if ! which brew >/dev/null; then
  echo "--- Installing homebrew ---"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo eval "$(/opt/homebrew/bin/brew shellenv)" >> "$ZPROFILE_PATH"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "--- homebrewがすでにインストールされております ---"
fi

if ! which brew >/dev/null; then
  echo "brew command not found."
  echo "Skips the install process of various applications."
  exit
fi

if [[ "$(uname)" == "Darwin" ]]; then
  echo "For macOS, install add 'hammerspoon'"
  brew install --cask hammerspoon
fi

echo "run brew doctor ..."
brew doctor

echo "run brew bundle ..."
brew bundle --file "$PWD"/homebrew/Brewfile

echo "run brew upgrade ..."
brew upgrade

echo "cleanup cache file of brew ..."
brew cleanup

echo "--- Package installation finished successfully ---"

