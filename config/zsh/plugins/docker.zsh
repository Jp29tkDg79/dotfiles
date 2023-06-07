#! bin/zsh

# Exitedなdockerプロセスを全て削除する
docker-clean() {
  # -rはコマンド引数が空の場合実行しないオプション
  command docker ps -aqf status=exited | xargs -r docker rm -- 
}

docker-cleani() {
  command docker images -qf dangling=true | xargs -r docker rmi --
}

docker-rm() {
  if [ "$#" -eq 0 ]; then
    local selected_container=$(docker ps -a | ${__FZF_CMD} ${__FZF_CMD_OPTS[@]} --prompt="docker rm > " | awk '{ print $1 }')
    if [ -n "$selected_container" ]; then
      command docker rm -- $selected_container
    fi
  else
    command docker rm "$@"
  fi
}

docker-rmi() {
  if [ "$#" -eq 0 ]; then
    local selected_container=$(docker images | ${__FZF_CMD} ${__FZF_CMD_OPTS} --prompt="docker rmi > " | awk '{ print $3 }')
    if [ -n "$selected_container" ]; then
      command docker rmi -- $selected_container
    fi
  else
    command docker rmi "$@"
  fi
}

docker-rund() {
  if [ "$#" -eq 0 ]; then
    local container_id=$(docker images | ${__FZF_CMD} ${__FZF_CMD_OPTS} --prompt="docker run(detached mode) > " | awk '{ print $3 }')
    if [ -n "$container_id" ]; then
      command docker run -d $container_id
    fi
  fi
}

docker-runit() {
  if [ "$#" -eq 0 ]; then
    local container_id=$(docker images | ${__FZF_CMD} ${__FZF_CMD_OPTS} --prompt="docker run(attach mode) > " | awk '{ print $3 }')
    if [ -n "$container_id" ]; then
      read shell"?Enter if you want to use a shell other than the default shell: "
      if [ -z "$shell" ]; then
        command docker run -it $container_id
      else
        command docker run -it $container_id $shell
      fi
    fi
  else
    command docker run -it "$@"
  fi
}
