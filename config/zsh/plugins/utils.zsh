#! bin/zsh

StartupTime() {
  local count=$1
  if [[ $# -eq 0 ]]; then
    count=1
  fi
  for i in $(seq 1 $count); do time zsh -i -c exit; done
}

ask_yes_or_no () {
  # read -k 1 flg"?${$1}(y/n): "
  # read -k 1 flg"?"$1"(y/n): "

  # echo "ok?(y/n): "; read -q && echo hello || echo abort 
  if read -q "ok?(y/n): "; then
    echo hello
  else
    echo abort
  fi
}

# Function to exec "mkdir" and "cd" command
mkd() {
  mkdir "$1" && cd "$_"
}
