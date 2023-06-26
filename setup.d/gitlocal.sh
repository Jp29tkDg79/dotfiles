#!/bin/bash

GIT_CONFIG_PATH=${XDG_CONFIG_HOME%/}/git

GIT_CONFIG_LOCAL=${GIT_CONFIG_PATH%/}/.gitconfig.local

if [[ -e $GIT_CONFIG_LOCAL ]]; then
  echo "The git config local already exists, Skip creation process."
  exit
fi

read -r -p "git config user.email > " email
read -r -p "git config user.name > " name
printf "[user]\n  name=%s\n  email=%s\n" "$name" "$email" > "$GIT_CONFIG_LOCAL"

echo "Saved the git config local file below."
echo "$GIT_CONFIG_LOCAL"
