#!/bin/bash

echo "Start the installation process of various applications ..."

SETUPD=$PWD/setup.d

idx=0

echo "-------------------------- Start -----------------------------------"
while :
do
  idx=$((idx+1))
  prs=$idx":"
  case "$idx" in
  1)
    echo "$prs Setup environment variables started ..."
    bash "$SETUPD"/exports.sh
    echo "$prs Setup environment variables end ..."
  ;;
  2)
    echo "$prs Create various folders in xdg config directory Started ..."
    bash "$SETUPD"/make.sh
    echo "$prs Create various folders in xdg config directory End ..."
  ;;
  3)
    echo "$prs Create git config for local use Started ..."
    bash "$SETUPD"/gitlocal.sh
    echo "$prs Create git config for local use End ..."
  ;;
  4)
    echo "$prs Setup xcode in MacOS Started ..."
    bash "$SETUPD"/xcode.sh
    echo "$prs Setup xcode in MacOS End ..."
  ;;
  5)
    echo "$prs Setup homebrew Started ..."
    bash "$SETUPD"/brew.sh
    echo "$prs Setup homebrew End ..."
  ;;
  6)
    echo "$prs Link settings for various applications Started ..."
    bash "$SETUPD"/links.sh
    echo "$prs Link settings for various applications End ..."
  ;;
  7)
    echo "$prs Install various application files using git clone Started ..."
    bash "$SETUPD"/gitclone.sh
    echo "$prs Install various application files using git clone End ..."
  ;;
  8)
    echo "$prs Install langs and some plugins Started ..."
    bash "$SETUPD"/build.sh
    echo "$prs Install langs and some plugins End ..."
  ;;
  *)
    break
  ;;
  esac
  echo # break line
done

echo "--------------------------      DONE     -----------------------------------"
