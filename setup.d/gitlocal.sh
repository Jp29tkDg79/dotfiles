#!/bin/sh

# This is for debugging.
# Add a value to the second argument when running in debug mode.
[[ -n $XDG_CONFIG_HOME ]] && XDG_CONFIG_HOME=$HOME/.config/

GIT_CONFIG_LOCAL=${XDG_CONFIG_HOME%/}/.gitconfig.local

echo "--- Set up git config local ---"

if [[ -e $GIT_CONFIG_LOCAL ]]; then
  echo "-- Git config local file exists, skipping ---"
  exit
fi
read -p "git config user.email > " email
read -p "git config user.name > " name
echo "[user]\n  name=$name\n  email=$email\n" > $GIT_CONFIG_LOCAL

echo "--- Created a git config local file in my home delirecotry ---"
