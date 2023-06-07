#! bin/zsh

# command after space
ZLE_REMOVE_SUFFIX_CHARS=$''

# history
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=1000000
SAVEHIST=$HISTSIZE

# autoload
# Enable directory change(cdr) and command history(history)
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# comp
autoload -Uz compinit && compinit

zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''
# Completion immediately if there are not more than two completion candidates
zstyle ':completion:*:default' menu select=2
# Colorize completion candidates
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# If there is no completion candidate, search with ambiguity.
# m:{a-z}={A-Z}: Completion even if lowercase letters are converted to uppercase letters.
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*' keep-prefix
zstyle ':completion:*' recent-dirs-insert both

# Complementary candidate.
### _oldlist     : Reuse previous completion suggestions.
### _complete    : complete.
### _match       : complete from list of candidates without expanding glob.
### _history     : Use history commands as completion candidates.
### _ignored     : completion candidates are also specified not to be displayed as completion candidates.
### _approximate : consider similar completion candidatesas as candidates.
### _prefix      : ignore after the cursor and complete up to the cursor.
#zstyle ':completion:*' completer _oldlist _complete _match _history _ignored _approximate _prefix
zstyle ':completion:*' completer _complete _ignored

# zsh history ignore --------
zshaddhistory() {
  local line="${1%%$'\n'}"
  [[ ! "$line" =~ "^(cd|j?|lazygit|lazydocker|cat|ls|la|ll|lt|rm|mkdir)($| )" ]]
}

# if homebrew is configured, add to path
# the homebrew path needs to be set before usr/bin, so add it to the beginning of the path.
[[ -d /opt/homebrew ]] && path=(/opt/homebrew/bin /opt/homebrew/sbin $path)

# ----------------------------
# Curl setting
# ----------------------------
__brewcurl=$(brew --prefix curl) 2>/dev/null
if [[ -n $__brewcurl ]]; then
  path=($__brewcurl/bin $path)
  export LDFLAGS="-L$__brewcurl/lib"
  export CPPFLAGS="-I$__brewcurl/include"
fi

# ----------------------------
# Openssl setting
# ----------------------------
__brewopssl=$(brew --prefix openssl) 2>/dev/null
if [[ -n $__brewopssl ]]; then
  path=($__brewopssl/bin $path)
  export LDFLAGS="-L$__brewopssl/lib"
  export CPPFLAGS="-I$__brewopssl/include"
  export PKG_CONFIG_PATH="$LDFLAGS/pkgconfig"
fi

# ----------------------------
# Sheldon setup
# ----------------------------
__ohmyzsh=${XDG_DATA_HOME%/}/sheldon/repos/github.com/ohmyzsh/ohmyzsh
if [[ -e $__ohmyzsh ]]; then
  export ZSH=$__ohmyzsh

  # oh my zsh settings
  plugins=(
    aliases    # With lots of 3rd-party amazing aliases installed, this plugin helps list the shortcuts that are currently available based on the plugins you have enabled.
    git        # The git plugin provides many alias(see:https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/README.md)
    web-search # This plugin adds aliases for searching with Google, Wiki, Bing, YouTube and other popular services.(ex: google <keyword>)
    docker     # This plugin adds auto-completion and aliases for docker(see:https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/docker/README.md)
    docker-compose # This plugin provides completion for docker-compose as well as some aliases for frequent docker-compose commands.
    emoji      # Support for conveniently working with Unicode emoji in Zsh.
  )
fi

if [[ $(command -v sheldon) ]]; then
  eval "$(sheldon source)"
  export EDITOR=nvim sheldon edit
fi

# starship
[[ $(command -v starship) ]] && eval "$(starship init zsh)"

# pyenv setting
[[ $(command -v pyenv) ]] && eval "$(pyenv init --path)"
