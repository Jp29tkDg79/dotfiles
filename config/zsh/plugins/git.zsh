#! bin/zsh

# git 
# setting git root dir
set_git_root_valiable() {
  # Discard standard error
  GIT_ROOT=$(git rev-parse --show-toplevel 2> /dev/null)
}
# Set the function to be automatically processed when any commnad is executed
autoload -Uz add-zsh-hook
add-zsh-hook precmd set_git_root_valiable
# Commit all changed files and push to github as the latest version of the current branch
# gacp () {
#   # Check if current folder is managed by git repository
#   if [[ -z $GIT_ROOT ]] then
#     echo "The current folder is not managed git."
#     echo "Please run \`git init\` first."
#     return 1 # TODO: change to exit code?
#   fi
#   # check if there is a git diff in the current folder
#   git diff --exit-code --quiet || return 1;
#   if [[ $? -ne 1 ]]; then
#     echo "There are no diffs in the current repository."
#     return 1
#   fi
#   git add . && git status
#   read message"?Enter your commit message: "
#   git commit -m ${message}
#   echo "Commit with $message."
#   read -k 1 flg"?Do you want to push the current branch (y/n): "
#   if [[ $flg -eq [Yy] ]]; then
#     git push origin HEAD
#     echo "Successful push to remote repository."
#   else
#     echo "Did't push to remote repository."
#   fi
# }

git-commit-push () {
  # Check if current folder is managed by git repository
  if [ -z $GIT_ROOT ]; then
    echo "The current folder is not managed git."
    echo "Please run \`git init\` first."
    return 1
  fi
  # check if there is a git diff in the current folder
  git diff --exit-code --quiet 2> /dev/null
  if [ $? -ne 1 ]; then
    echo "There are no diffs in the current repository."
    return 1
  fi
  git add . && git status
  read message"?Enter your commit message: "
  command git commit -m ${message}
  if read -q "Do you want to push the current branch (y/n): "; then
    git push origin HEAD
    echo "Successful push to remote repository."
  else
    echo "Did't push to remote repository."
  fi
}

git-init() {
  if [ -n $GIT_ROOT ]; then
    echo "Current repository is managed by git."
    return 1
  fi
  if [ ! -e ./README.md ]; then
    echo "Create a README file because it does not exist."
    read reponame"?Enter repository name: "
    echo "#"$reponame > ./README.md
    echo "You have successfully created a README file!"
  fi
  command git add .
  echo "\`git add\` command executed successfully."
  command git commit -m "Initail commit"
  # TODO: create remote repository ?
}

# TODO: 編集する
# gicrp () {
#   read -k 1 flg"?Create current folder as git repository (y/n): "
#   if [[ flg = [Yy] ]]; then
#      # if [ -e ]
#   fi
# }

# _mygcre () {
# 	git init && git add . && git status && git commit -m "First commit"
#     echo "Type repository name: " && read name;
#     echo "Type repository description: " && read description;
#     curl -u YOURID:YOURPASSWORD https://api.github.com/user/repos -d '{"name":"'"${name}"'","description":"'"${description}"'","private":true}'
#     git remote add origin https://github.com/deatiger/${name}.git
#     git checkout -b develop;
#     git push -u origin develop;
# }

