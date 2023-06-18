#!/bin/sh

# This is for debugging.
# Add a value to the second argument when running in debug mode.
[[ -n $XDG_CONFIG_HOME ]] && XDG_CONFIG_HOME=$HOME/.config/

if ! which git >/dev/null && [[ -d ${XDG_CONFIG_HOME%/}/alacritty/themes ]]; then
  git clone https://github.com/eendroroy/alacritty-theme.git ${XDG_CONFIG_HOME%/}/alacritty/
  echo "alacritty theme install successfully."
else
  echo "Already have alacritty themes installed."
fi

