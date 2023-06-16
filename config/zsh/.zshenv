#! bin/zsh

# lang
export LANG=ja_JP.UTF-8

# xdg config settings
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# zsh home dir
export ZDOTDIR=${XDG_CONFIG_HOME%/}/zsh

# nvm setup ----------------
export NVM_DIR=${XDG_CONFIG_HOME%/}/.nvm
# node history
export NODE_REPL_HISTORY=${XDG_CONFIG_HOME%/}/node_history

# cargo setup
export CARGO_HOME=${XDG_CONFIG_HOME%/}/cargo
# . ${CARGO_HOME%/}/env

# pyenv setting -------------
export PYENV_ROOT=${XDG_CONFIG_HOME%/}/.pyenv

# golang setting ------------
export GOPATH=${XDG_CONFIG_HOME%/}/go

# docker setting ------------
export DOCKER_CONFIG=${XDG_CONFIG_HOME%/}/docker

# minikube setting ----------
export MINIKUBE_HOME=${XDG_CONFIG_HOME%/}/minikube

# Do not add duplicate values to path
typeset -U path PATH
# path setting --------------
# `(N-/)` is an option to add the path the environment variable if it exists,
# and not to add it if it does not exist
export path=(
  /usr/local/{bin,sbin}/(N-/)
  /Library/Apple/usr/bin(N-/)
  ${PYENV_ROOT%/}/bin(N-/) # using pyenv
  /bin
  /usr/bin
  /sbin
)

# source cargo env (using rustup,cargo etc)
. ${CARGO_HOME%/}/env
