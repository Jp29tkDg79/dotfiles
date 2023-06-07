#! bin/zsh

brew-install () {
  local inst=$(brew search "$@" | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --prompt="brew install > ")
  if [[ $inst ]]; then
    for prog in $(echo $inst);
    do; brew install $prog; done;
  fi
}

brew-upgrade () {
  local upd=$(brew leaves | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --prompt="brew upgrade > ")
  if [[ $upd ]]; then
    for prog in $(echo $upd);
    do; brew upgrade $prog; done;
  fi
}

brew-uninstall () {
  local uninst=$(brew leaves | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --prompt="brew clean package > ")
  if [[ $uninst ]]; then
    for prog in $(echo $uninst);
    do; brew uninstall $prog; done;
  fi
}
