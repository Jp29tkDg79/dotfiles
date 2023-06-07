#!/bin/sh

echo "Start the installation process of various applications ..."

# using xdg directory specification.
export XDG_CONFIG_HOME=$HOME/.config/
export XDG_CACHE_HOME=$HOME/.cache/
export XDG_DATA_HOME=$HOME/.local/share/

SETUPD=$PWD/setup.d

idx=0

while :
do
  let idx=$idx+1
  echo "-------------------------- Start (No.$idx) -----------------------------------"
  case "$idx" in
  1)
    echo $no"[Create various required directories] Started ..."
    sh $SETUPD/make.sh
    echo $no"[Created various required directories] End ..."
  ;;
  2)
    echo $no"[Create git config local file] Started ..."
    sh $SETUPD/gitlocal.sh
    echo $no"[Create git config local file] End ..."
  ;;
  3)
    echo "set up homebrew ..."
    sh $SETUPD/brew.sh
    echo "Package installation finished successfully."
  ;;
  4)
    echo "set up xcode in MacOS."
    sh $SETUPD/xcode.sh
  ;;
  5)
    echo "create links."
    sh $SETUPD/links.sh
  ;;
  6)
    echo "install tmux plugin tpm ..."
    sh $SETUPD/tmux.sh
  ;;
  7)
    echo "Install zsh plugin using sheldon ..."
    if which sheldon >/dev/null; then
      echo "set up sheldon ..."
      sheldon lock --update
    fi
  ;;
  8)
    echo "Install themes ..."
    sh $SETUPD/theme.sh
  ;;
  9)
    echo "Install nvim plugins ..."
    [[ $(command -v nvim) ]] && nvim --headless "+Lazy! sync" +qa
  ;;
  *)
    break
  ;;
  esac
  echo "--------------------------  End (No.$idx)  -----------------------------------"
done

echo "--------------------------      DONE     -----------------------------------"
