#!/bin/bash

ignore_dir=(
  homebrew
  setup.d
  .github
)

ignore_file=(
  .DS_Store
  .stylua.toml
  LICENSE
  README.md
  bootstrap.sh
  .yamllint.yml
)

home_file=(
  .zshenv
  .gitconfig
  .editorconfig
)

paths=()
for f in *; do
  [[ $f == "$0" ]] && continue
  [[ ! -d $f ]] && paths+=("$f") && continue
  echo "${ignore_dir[@]}" | xargs -n 1 | grep -E "^${f##*/}$" >/dev/null && continue
  for c in 1 2; do
    case "$c" in
      1)
        find_path=$(find "$f" -mindepth 1 -maxdepth 1 -type f)
      ;;
      2)
        find_path=$(find "$f" -mindepth 2 -maxdepth 2)
      ;;
    esac
    for ff in $find_path; do
      paths+=("$ff")
    done
  done
done

for fp in "${paths[@]}"; do
  fn=${fp##*/}
  echo "${ignore_file[@]}" | xargs -n 1 | grep -E "^$fn$" >/dev/null && continue
  dir=${fp%/*}
  [[ ! $dir == */* ]] && dir=/
  to=$HOME
  echo "${home_file[@]}" | xargs -n 1 | grep -E "^$fn$" >/dev/null || to=${XDG_CONFIG_HOME%/}"/"${dir##*/}
  [[ ! -d $to ]] && mkdir -p "$to"
  echo "$PWD/$fp → $to"
  ln -sf "$PWD/$fp" "$to"
done

# For MacOS. set the hammerspoon link.
if [[ "$(uname)" != "Darwin" ]]; then
  echo "Skipping hammerspoon configuration as it's not MacOS."
  exit
fi

echo "For MacOS, creating a link for hammerspoon ..."
echo "$PWD/.hammerspoon/ → $HOME"
ln -sf "$PWD"/.hammerspoon "$HOME"
echo "hammerspoon configuration completed successfully."
