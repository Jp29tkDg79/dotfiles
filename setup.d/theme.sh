#!/bin/sh

# This is for debugging.
# Add a value to the second argument when running in debug mode.
[[ -n $XDG_CONFIG_HOME ]] && XDG_CONFIG_HOME=$HOME/.config/

if ! which git>/dev/null; then
  git clone https://github.com/eendroroy/alacritty-theme.git ${XDG_CONFIG_HOME%/}/alacritty/
fi

echo "alacritty theme install successfully."
