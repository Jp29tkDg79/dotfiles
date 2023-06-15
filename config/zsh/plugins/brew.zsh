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

# Commented out because `brew uninstall` does not remove dependencies `formulae` togerther.
# brew-uninstall () {
#   local uninst=$(brew leaves | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --prompt="brew clean package > ")
#   if [[ $uninst ]]; then
#     for prog in $(echo $uninst);
#     do; brew uninstall $prog; done;
#   fi
# }

brew-rm () {
  local rminst=$(brew leaves | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --prompt="brew rmtree > ")
  if [[ $rminst ]]; then
    for prog in $(echo $rminst);
    do; brew rmtree $prog; done;
  fi
}
