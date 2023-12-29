#!/bin/bash

if ! which git>/dev/null; then
  echo "git command not found, skip clone process."
  exit
fi

# TPM(tmux plugin manager) path
TPM_PATH=${XDG_CONFIG_HOME%/}/tmux/plugins/
if ! which tmux>/dev/null; then
  echo "tmux not found, skip tmp(tmux plugin manager) clone."
elif [[ ! -d $TPM_PATH ]]; then
  git clone https://github.com/tmux-plugins/tpm "$TPM_PATH"
else
  echo "Skip clone because the tpm dir already exists."
fi

# ALACRITTY_THEMES=${XDG_CONFIG_HOME%/}/alacritty/
# echo "clone alacritty themes ..."
# if [[ ! -d ${XDG_CONFIG_HOME%/}/alacritty/themes ]]; then
#   git clone https://github.com/eendroroy/alacritty-theme.git "$ALACRITTY_THEMES"
#   echo "alacritty theme install successfully."
# else
#   echo "Already have alacritty themes installed."
# fi
