#!/bin/bash

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
