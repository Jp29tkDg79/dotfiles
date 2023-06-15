# dotfiles
My Dotfiles

# Warning
- I use homebrew to install various applications. 
  - Therefore, it is designed to run on linuxOS or macOS.
- Assumes zsh is set as the default shell.

# Zsh default setup example
- macOS
  - Not required as zsh is configured by default.

- ubuntu (example)
  1. ```apt-get install zsh```
  2. ```chsh -s $(which zsh)```

# Usage
- Download the file from github as a zip file, unzip the zip file, and store it in your home dir.
- Start a terminal and navigate to the location where you solved the zip.
- ```sh ./bootstrap.sh```
- Enter your username and email registerd in github.
  - skip this step if you already have ```$XDG_CONFIG_HOME/.gitconfig.local```
- Note:Please close the terminal that was started in the environment construction and start a new one, because the zsh setting is not reflected.

# Nvm(nodejs version manager) setup
- When using nodejs lts version:
  - ```nvmlts``` or ```nvm install --lts && nvm alias default 'lts/*'```

# Pyenv setup
- When using python lts version:
- Note: The following command installs the latest version of the python3 series.
  - ```pyenvlts``` or ```pyenv install $(pyenv latest -k 3) && pyenv global $(pyenv latest -k 3)```

# Rust
- Installation procedure for the latest version stable version using ```rustup-init```
  1. ```rustup-init```
  2. Enter any value for the question.
  3. ```exec $SHELL -l``` (Reload shell.)
  4. ```rustup update stable```

# Note
- On macOS, it can be activated with a double-click using hammerspoon, but on other os, the hotkey must be set manually.

# Thanks you
- [Mathias Bynens](https://mathiasbynens.be/) and his [dotfiles repository](https://github.com/mathiasbynens/dotfiles)
- Created nvim config with ref to [LazyVim](https://github.com/LazyVim/LazyVim)

# Author
- Jp29tkDg79

# License
See [LICENSE](./LICENSE)
