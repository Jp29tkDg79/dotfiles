#! bin/zsh

# lang
export LANG=ja_JP.UTF-8

# xdg config settings
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME="$HOME"/.local/state

# zsh home dir
export ZDOTDIR=${XDG_CONFIG_HOME%/}/zsh

# nvm setup
export NVM_DIR=${XDG_CONFIG_HOME%/}/.nvm

# cargo setup
. "$HOME/.cargo/env"

typeset -U path PATH

# pyenv setting -------------
export PYENV_ROOT="$HOME/.pyenv"

# path setting --------------
# `(N-/)` is an option to add the path the environment variable if it exists,
# and not to add it if it does not exist
export path=(
  /usr/local/bin/(N-/)
  /usr/local/sbin(N-/)
  /Library/Apple/usr/bin(N-/)
  $PYENV_ROOT/bin(N-/) # using pyenv
  /bin
  /usr/bin
  /sbin
)

