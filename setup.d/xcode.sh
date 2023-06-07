#!/bin/sh

if [[ "$(uname)" != "Darwin" ]]; then
  echo "Skipping xcode command line installation as it's not MacOS."
  exit
fi

echo "--- Set up xcode-select ---"
if ! xcode-select --print-path &> /dev/null; then
  echo "Command line tools not found. Installing ..."
  xcode-select --install
  echo "Installation of command line tools is completed."
else
  echo "Command line tools are already installed."
fi
