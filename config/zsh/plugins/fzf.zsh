#! bin/zsh

# Options to fzf command
# Setting fd as the default source for fzf
if [[ -n ${TMUX-} ]]; then
  export FZF_DEFALT_OPTS="--height 70% --layout=reverse"
  export FZF_TMUX_OPTS="-p 80%"
  __FZF_CMD="fzf-tmux"
  __FZF_CMD_OPTS=(-p 80%)
else
  __FZF_CMD="fzf"
  __FZF_OPTS=()
  export FZF_DEFAULT_OPTS="--height 70% --layout=reverse --border"
fi

__FZF_FD_FILES_CMD=(fd --type f)
__FZF_FD_DIRS_CMD=(fd --type d)
__FZF_FD_ALL_OPTS=(--hidden --follow --exclude ".git")
__FZF_ALL_FILES_CMD=(${__FZF_FD_FILES_CMD[@]} ${__FZF_FD_ALL_OPTS[@]})
__FZF_FD_ALL_DIRS_CMD=(${__FZF_FD_DIRS_CMD[@]} ${__FZF_FD_ALL_OPTS[@]})
__FZF_FILE_PREVIEW_CMD=(bat --style=numbers --color=always --line-range: 100 '{}')

# -------------------------------------------------
# cdrをfzf経由で選択して実行
# -------------------------------------------------
# こちらを参考に https://gist.github.com/siriusjack/0b0032f22c72ffc7e5ba217f80674ad2
function fzf-cdr () {
  local selected_dir=$(cdr -l | awk '{ print $2 }' | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --prompt="cdr > " --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    local BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N fzf-cdr
# key bindはお好みで
bindkey "^@" fzf-cdr

# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

# -------------------------------------------------
# git branchをfzf経由で選択
# -------------------------------------------------
# PREVIEWでgit logを見る。--allの切り替えを可能に。
# こちらを参考に https://zenn.dev/yamo/articles/5c90852c9c64ab
function select-git-switch() {
  local target_br=$(
    git branch |
       ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --exit-0 --layout=reverse --info=hidden --no-multi \
       --prompt="git branch > " \
       --header=$'Press CTRL-A: --all, Ctrl-D: default\n\n' \
       --bind "ctrl-d:change-prompt(git branch >  )+reload(git branch)" \
       --bind "ctrl-a:change-prompt(git branch --all > )+reload(git branch --all | grep -v 'remotes/origin/HEAD')" \
       --preview-window="right,65%" \
       --preview="echo -e {} | tr -d ' *' | xargs git log --graph --decorate --abbrev-commit --format=format:'%C(blue)%h%C(reset) - %C(green)(%ar)%C(reset)%C(yellow)%d%C(reset)'$'\n'' %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --color=always" | \
       head -n 1 | \
       perl -pe "s/\s//g; s/\*//g; s/remotes\/origin\///g"
  )
  if [ -n "$target_br" ]; then
    local BUFFER="git switch $target_br"
    zle accept-line
  fi
}
zle -N select-git-switch
# key bindはお好みで
bindkey "^g" select-git-switch

# alias fzf
function fzf-alias() {
  local als=$(alias |
    sed 's/=/\t/' |
    column -s '	' -t |
    ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --exit-0 --layout=reverse --no-multi --prompt='alias > ' --preview='echo {2..}' |
    awk '{print $1}'
  )
  if [ -n "$als" ]; then
    local BUFFER="$als " # Insert a space at the end of make it easier to type the next command.
    zle end-of-line # move the cursor end of line
    zle redisplay
  fi
}

zle -N fzf-alias
bindkey "^@" fzf-alias

# fgを使わずctrl+zで行ったり来たりする
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# -------------------------------------------------
# fzf-cd-widget
# -------------------------------------------------
# previewではdir treeを表示
# OS XでALT-Cのkey bind (カレントディレクトリ以下のcd)を機能させる => opt-Cで起動 (もう少しsmartな方法はないのか...)
bindkey "ç" fzf-cd-widget
export FZF_ALT_C_OPTS="--prompt='dirs > ' --no-multi --preview '${__FZF_DIR_PREVIEW_CMD[*]}'
            --header=$'Press CTRL-R: --hidden --follow, Ctrl-D: default\n\n'
            --bind 'ctrl-d:change-prompt(dirs > )+reload(${__FZF_FD_DIRS_CMD[*]} .)'
            --bind 'ctrl-a:change-prompt(all dirs > )+reload(${__FZF_FD_ALL_DIRS_CMD[*]} .)'"
export FZF_ALT_C_COMMAND="${__FZF_FD_DIRS_CMD[*]}"

# Ctrl + tのwidget
export FZF_CTRL_T_OPTS="--prompt='files > ' --preview '${__FZF_FILE_PREVIEW_CMD[*]}'
            --header=$'Press CTRL-R: --hidden --follow, Ctrl-D: default\n\n'
            --bind 'ctrl-d:change-prompt(files > )+reload(${__FZF_FD_FILES_CMD[*]} .)'
            --bind 'ctrl-a:change-prompt(all files > )+reload(${__FZF_FD_ALL_FILES_CMD[*]} .)'"
export FZF_CTRL_T_COMMAND="${__FZF_FD_FILES_CMD[*]}"

# -------------------------------------------------
# **<TAB>の補完
# -------------------------------------------------
__FZF_COMP_TMP_DIR=/tmp/__fzf_comp
[[ ! -d ${__FZF_COMP_TMP_DIR} ]] && mkdir -p ${__FZF_COMP_TMP_DIR}
__CURRENT_SH_PID=$$
__FZF_COMPGEN_PATH_ARG_FILE=${__FZF_COMP_TMP_DIR}/compgen_path.${__CURRENT_SH_PID}
__FZF_COMPGEN_DIR_ARG_FILE=${__FZF_COMP_TMP_DIR}/compgen_dir.${__CURRENT_SH_PID}



# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  # 下記のように変数に確保しておいて_fzf_comprun()で使いたいが、どうもサブシェルで起動されるのかここでの変数退避が後に反映されない。
  # __FZF_COMPGEN_PATH_ARG="$1"
  # よって、一時ファイルに一旦退避する
  echo "$1" > ${__FZF_COMPGEN_PATH_ARG_FILE}
  ${__FZF_FD_FILES_CMD[@]} . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  echo "$1" > ${__FZF_COMPGEN_DIR_ARG_FILE}
  ${__FZF_FD_DIRS_CMD[@]} . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  # コマンドごとにoptionを変える
  case "$command" in
    (cd)
        __FZF_COMPGEN_DIR_ARG=$(<${__FZF_COMPGEN_DIR_ARG_FILE})
        ${__FZF_CMD} "$@" ${__FZF_CMD_OPTS[@]} --no-multi --prompt='dirs > ' --preview "${__FZF_DIR_PREVIEW_CMD[*]}" \
            --header=$'Press CTRL-R: --hidden --follow, Ctrl-D: default\n\n' \
            --bind "ctrl-d:change-prompt(dirs > )+reload(${__FZF_FD_DIRS_CMD[*]} . ${__FZF_COMPGEN_DIR_ARG})" \
            --bind "ctrl-a:change-prompt(all dirs > )+reload(${__FZF_FD_ALL_DIRS_CMD[*]} . ${__FZF_COMPGEN_DIR_ARG})"
        rm ${__FZF_COMPGEN_DIR_ARG_FILE}
        ;;
    (cat|bat|nvim)
        __FZF_COMPGEN_PATH_ARG=$(<${__FZF_COMPGEN_PATH_ARG_FILE})
        ${__FZF_CMD} "$@" ${__FZF_CMD_OPTS[@]} --prompt='files > ' --preview "${__FZF_FILE_PREVIEW_CMD[*]}" \
            --header=$'Press CTRL-R: --hidden --follow, Ctrl-D: default\n\n' \
            --bind "ctrl-d:change-prompt(files > )+reload(${__FZF_FD_FILES_CMD[*]} . ${__FZF_COMPGEN_PATH_ARG})" \
            --bind "ctrl-a:change-prompt(all files > )+reload(${__FZF_FD_ALL_FILES_CMD[*]} . ${__FZF_COMPGEN_PATH_ARG})"
        rm ${__FZF_COMPGEN_PATH_ARG_FILE}
        ;;
    (*)
        ${__FZF_CMD} "$@" ${__FZF_CMD_OPTS[@]}
        ;;
  esac
}

# Commented out to use autojump
# cd() {
#     if [[ "$#" != 0 ]]; then
#         builtin cd "$@";
#         return
#     fi
#     while true; do
#         local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
#         local dir="$(printf '%s\n' "${lsd[@]}" |
#             fzf --reverse --preview '
#                 __cd_nxt="$(echo {})";
#                 __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
#                 echo $__cd_path;
#                 echo;
#                 ls -p --color=always "${__cd_path}";
#         ')"
#         [[ ${#dir} != 0 ]] || return 0
#         builtin cd "$dir" &> /dev/null
#     done
# }

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# autojump integration fzf
j() {
    if [[ "$#" -ne 0 ]]; then
        cd $(autojump $@)
        return
    fi
    # cd "$(autojump -s | sort -k1gr | awk '$1 ~ /[0-9]:/ && $2 ~ /^\// { for (i=2; i<=NF; i++) { print $(i) } }' |  fzf --height 40% --reverse --inline-info)" 
    cd "$(autojump -s | sort -k1gr | awk '$1 ~ /[0-9]:/ && $2 ~ /^\// { for (i=2; i<=NF; i++) { print $(i) } }' | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --prompt='autojump > ')" 
}

# My create function 
# ghq setting
ghq-fzf() {
  local src=$(ghq list | fzf --preview "ls -laTp $(ghq root)/{} | tail -n+4 | awk '{print \$9\"/\"\$6\"/\"\$7 \" \" \$10}'")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^]' ghq-fzf
