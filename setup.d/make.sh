#!/bin/sh

# This is for debugging.
# Add a value to the second argument when running in debug mode.
[[ -n $XDG_CONFIG_HOME ]] && XDG_CONFIG_HOME=$HOME/.config/
[[ -n $XDG_CACHE_HOME ]] && XDG_CACHE_HOME=$HOME/.cache/
[[ -n $XDG_DATA_HOME ]] && XDG_DATA_HOME=$HOME/.local/share/

echo "--- Create xdg config directory ---"
for p in $XDG_CONFIG_HOME $XDG_CACHE_HOME $XDG_DATA_HOME
do
  echo $p
  [[ ! -d $p ]] && mkdir -p $p
done
echo "--- Successfully created xdg config directory ---"

