#! bin/zsh

# global alias ----------
alias -g G="| grep"
alias -g L="| less"
alias -g H="| head"
alias -g T="| tail"
alias -g S="| sed"
alias -g C="| cat"
if [[ $(command -v jq) ]]; then
  alias -g J="| jq"
fi
# move path
alias -g ..=".."
alias -g ...="../.."
alias -g ....="../../.."

# general ---------------
alias c="clear"
alias cls="clear" # For clearing the prompt as in windows
alias :wq="exit"
alias :q="exit"

# safety measure -------
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# history --------------
alias history='history -t "%F %T"'

# homebrew --------------------
if [[ $(command -v brew) ]]; then
  # Command out because I added an alias for the brew command in oh-my-zsh
  # alias br="brew"
  # alias brup="brew upgrade && brew cleanup --prune=all"
  # alias brin="brew install"
  # alias brrin="brew reinstall"
  # alias brun="brew uninstall"
  alias brrm="brew rmtree"
  alias brls="brew list"
  # alias brpf="brew --prefix"
  alias brus="brew uses --installed"
  # alias brclpr="brew cleanup --prune=all"
  alias brdct="brew doctor"
  alias brdmp="rm -f Brewfile 2>/dev/null || true && brew bundle dump"
fi

# vim(neoVim or vim) -----------
if [[ $(command -v nvim) ]]; then
  alias vi="nvim"
  alias vim="nvim"
  alias view="nvim -R"
else
  alias vi="vim"
  alias vim="vim"
  alias view="vim -R"
fi

# bat setup -------------
if [[ $(command -v bat) ]]; then
  alias cat="bat"
fi

# exa setup -------------
if [[ $(command -v exa) ]]; then
  alias e='exa --icons --git'
  alias l=e
  alias ls=e
  alias ea='exa -a --icons --git'
  alias la=ea
  alias ee='exa -aahl --icons --git'
  alias ll=ee
  alias et='exa -T -L 3 -a -I "node_modules|.git|.cache" --icons'
  alias lt=et
  alias eta='exa -T -a -I "node_modules|.git|.cache" --color=always --icons | less -r'
  alias lta=eta
  alias l='clear && ls'
fi

# git ------------------------------------
alias lg="lazygit"

# docker ---------------------------------
if [[ $(command -v docker) ]]; then
  # see: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
  alias d="docker"
  alias dvpr="docker volume prune"
  alias dsypr="docker system prune"
  alias dps="docker ps"
  alias dpsa="docker ps -a"
  alias ld="lazydocker"
  # docker-compose alias ----------------
  alias dco="docker compose"
  alias dcb="docker compose build"
  alias dce="docker compose exec"
  alias dcps="docker compose ps"
  alias dcrestart="docker compose restart"
  alias dcrm="docker compose rm"
  alias dcr="docker compose run"
  alias dcstop="docker compose stop"
  alias dcup="docker compose up"
  alias dcupb="docker compose up build"
  alias dcupd="docker compose up -d"
  alias dcupdb="docker compose -d --build"
  alias dcdn="docker compose down"
  alias dcl="docker compose logs"
  alias dclf="docker compose logs -f"
  alias dcpull="docker compose pull"
  alias dcstart="docker compose start"
  alias dck="docker compose kill"
fi

# nvm -----------------------------------
if [[ $(command -v nvm) ]]; then
  # install nodejs lts(long term support) version of nvm and set up aliases
  alias nvmlts="nvm install --lts && nvm alias default 'lts/*'"
  alias nvmvers="nvm ls-remote" # TODO: changing fzf > install > alias
  alias nvmltnpm="nvm install-latest-npm"
fi

# pyenv ---------------------------------
if [[ $(command -v pyenv) ]]; then
  # install python3 with pyenv and set defaults.
  # TODO: Need to update when a new version is released, such as python4.
  alias pyenvlts="pyenv install $(pyenv latest -k 3) && pyenv global $(pyenv latest -k 3)"
fi

# other ---------------------
alias ascaq="asciiquarium"
alias tetris="tetriscurses"
