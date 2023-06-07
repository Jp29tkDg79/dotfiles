#!/bin/sh

# This is for debugging.
# Add a value to the second argument when running in debug mode.
[[ -n $XDG_CONFIG_HOME ]] && $HOME/.config/
[[ ! -d $XDG_CONFIG_HOME ]] && mkdir -p $XDG_CONFIG_HOME

ignore_dir=(
  homebrew
  setup.d
)

ignore_file=(
  .DS_Store
  .stylua.toml
  LICENSE
  README.md
  bootstrap.sh
)

home_file=(
  .zshenv
  .gitconfig
)

paths=()
for f in *; do
  [[ $f == $0 ]] && continue
  [[ ! -d $f ]] && paths+=($f) && continue
  echo ${ignore_dir[@]} | xargs -n 1 | grep -E "^${f##*/}$" >/dev/null && continue
  for ff in `find $f -mindepth 1 -maxdepth 1 -type f`; do
    paths+=($ff)
  done
  for ff in `find $f -mindepth 2 -maxdepth 2`; do
    paths+=($ff)
  done
done

for fp in ${paths[@]}; do
  fn=${fp##*/}
  echo ${ignore_file[@]} | xargs -n 1 | grep -E "^$fn$" >/dev/null && continue
  dir=${fp%/*}
  [[ ! $dir == */* ]] && dir=/
  to=$HOME
  echo ${home_file[@]} | xargs -n 1 | grep -E "^$fn$" >/dev/null || to=${XDG_CONFIG_HOME%/}"/"${dir##*/}
  [[ ! -d $to ]] && mkdir -p $to
  echo $PWD"/"$fp" → "$to
  ln -sf $PWD"/"$fp $to
done

# For MacOS. set the hammerspoon link.
if [[ "$(uname)" != "Darwin" ]]; then
  echo "Skipping hammerspoon configuration as it's not MacOS."
else
  echo "For MacOS, creating a link for hammerspoon ..."
  echo $PWD/.hammerspoon/" → "$HOME
  ln -sf $PWD/.hammerspoon $HOME
  echo "hammerspoon configuration completed successfully."
fi
