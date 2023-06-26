#!/bin/bash

if [[ "$(uname)" != "Darwin" ]]; then
  echo "Skipping xcode command line installation as it's not MacOS."
  exit
fi

if xcode-select --print-path &>/dev/null; then
  echo "Command line tools are already installed."
  exit
fi

xcode-select --install
