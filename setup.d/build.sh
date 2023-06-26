#!/bin/bash

# Terminate the prcess if you do not install any programming lang, etc.
read -n1 -r -p " Install langs(nodejs,py,rust), some plugins..?(y/n) > " ans; 
  [[ ! $ans = [yY] ]] && 
  echo && # break line
  exit


idx=0
while :
do
  idx=$((idx+1))
  prs=" $idx."
  echo  # break line.
  case "$idx" in
    1)
      echo "$prs Install the latest version of python Started."
      [[ ! $(command -v pyenv) ]] && echo " pyenv not found. Skip python install process." && continue
      while true
      do
        read -n1 -r -p " Enter the version of python > " version
        echo  # break line.
        [[ $(pyenv latest -q "$version") ]] && break
        echo " The version entered is not managed by pyenv, try again."
      done
      # Skip if the entered python version is installed
      [[ $(command -v python) || $(command -v python"$version") ]] && echo " Already python installed." && continue
      pyenv install "$(pyenv latest -k "$version")" && pyenv global "$(pyenv latest -k "$version")"
      echo "$prs Install the latest version of python End."
    ;;
    2)
      echo "$prs Install zsh some plugins using sheldon."
      which sheldon >/dev/null && sheldon lock --update
      echo "$prs Install zsh some plugins using sheldon End."
    ;;
    3)
      echo "$prs Install the latest version of nodejs Started."
      [[ ! $(command -v nvm) ]] && echo " nvm not found. Skip nodejs install process." && continue
      [[ $(command -v node) ]] && echo " Already nodejs installed." && continue
      nvm install --lts && nvm alias default 'lts/*'
      echo "$prs Install the latest version of nodejs End."
    ;;
    4)
      echo "$prs Install various plugins for use with neovim Started."
      [[ $(command -v nvim) ]] && nvim --headless "+Lazy! sync" +qa
      echo "$prs Install various plugins for use with neovim End."
    ;;
    *)
      break
    ;;
  esac
done

