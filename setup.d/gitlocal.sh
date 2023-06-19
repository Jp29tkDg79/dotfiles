#!/bin/sh

GIT_CONFIG_LOCAL=${XDG_CONFIG_HOME%/}/.gitconfig.local

if [[ -e $GIT_CONFIG_LOCAL ]]; then
  echo "The git config local already exists, Skip creation process."
  exit
fi

read -p "git config user.email > " email
read -p "git config user.name > " name
echo "[user]\n  name=$name\n  email=$email\n" > $GIT_CONFIG_LOCAL

