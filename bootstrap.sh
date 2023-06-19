#!/bin/sh

echo "Start the installation process of various applications ..."

SETUPD=$PWD/setup.d

idx=0

echo "-------------------------- Start -----------------------------------"
while :
do
  let idx=$idx+1
  case "$idx" in
  1)
    echo $idx": Setup environment variables started ..."
    sh $SETUPD/exports.sh
    echo $idx": Setup environment variables end ..."
  ;;
  2)
    echo $idx": Create various folders in xdg config directory Started ..."
    sh $SETUPD/make.sh
    echo $idx": Create various folders in xdg config directory End ..."
  ;;
  3)
    echo $idx": Create git config for local use Started ..."
    sh $SETUPD/gitlocal.sh
    echo $idx": Create git config for local use Eed ..."
  ;;
  4)
    echo $idx": Setup xcode in MacOS Started ..."
    sh $SETUPD/xcode.sh
    echo $idx": Setup xcode in MacOS Eed ..."
  ;;
  5)
    echo $idx": Setup homebrew Started ..."
    sh $SETUPD/brew.sh
    echo $idx": Setup homebrew End ..."
  ;;
  6)
    echo $idx": Link settings for various applications Started ..."
    sh $SETUPD/links.sh
    echo $idx": Link settings for various applications Eed ..."
  ;;
  7)
    echo $idx": Install various application files using git clone Started ..."
    sh $SETUPD/gitclone.sh
    echo $idx": Install various application files using git clone Eed ..."
  ;;
  8)
    echo $idx": Install zsh plugin using sheldon Started ..."
    which sheldon >/dev/null && sheldon lock --update
    echo $idx": Install zsh plugin using sheldon Eed ..."
  ;;
  9)
    echo $idx": Install various plugins for use with neovim Started ..."
    [[ $(command -v nvim) ]] && nvim --headless "+Lazy! sync" +qa
    echo $idx": Install various plugins for use with neovim Eed ..."
  ;;
  10)
  ;;
  *)
    break
  ;;
  esac
done

echo "--------------------------      DONE     -----------------------------------"
