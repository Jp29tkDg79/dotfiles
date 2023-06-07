#!/bin/sh

# This is for debugging.
# Add a value to the second argument when running in debug mode.
[[ -n $XDG_CONFIG_HOME ]] && XDG_CONFIG_HOME=$HOME/.config/

TPM_PATH=${XDG_CONFIG_HOME%/}/tmux/plugins/

if ! which tmux>/dev/null; then
  echo "tmux not found. Skipping tmux package manager."
  exit
fi

if ! which git>/dev/null; then
  echo "git not found."
  exit
fi

if [[ ! -d $TPM_PATH ]]; then
  git clone https://github.com/tmux-plugins/tpm $TPM_PATH
fi

echo "tmux plugin install successfully."
