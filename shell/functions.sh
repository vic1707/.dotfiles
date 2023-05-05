#!/bin/bash

# extract archives
function ex() {
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.tar.xz)    tar xJf "$1"     ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar x "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# check if command exists, one version exit if not, the other is a boolean
# if $2 is provided, exit if command does not exist
function __command_exists() {
  if command -v "$1" &> /dev/null; then
    return 1
  elif type -p "$1" &> /dev/null; then
    return 1
  elif hash "$1" &> /dev/null; then
    return 1
  elif which "$1" &> /dev/null; then
    return 1
  elif $1 --version &> /dev/null; then
    return 1
  fi
  echo "Command $1 does not exist"
  [[ -n "$2" ]] && exit 1
  return 0
}

function __nvm_uptodate() {
  NVM_VERSION=$(\. "$HOME/.nvm/nvm.sh" && nvm -v)
  LATEST_NVM_REMOTE=$(curl --silent "https://api.github.com/repos/nvm-sh/nvm/releases/latest" | \
      grep '"tag_name":' | \
      head -1 | \
    sed -E 's/.*"([^"]+)".*/\1/')
  if [ "v$NVM_VERSION" != "$LATEST_NVM_REMOTE" ]; then
    return 1
  fi
  return 0
}

# update all zsh plugins, cargo installs, etc
function __update_all() {
  # update zsh plugins in "$HOME/.ditfiles/zsh-plugins"
  for plugin in "$HOME/.dotfiles/zsh-plugins/"*; do
    if [ -d "$plugin" ]; then
      echo "Updating $plugin"
      cd "$plugin" || exit
      git pull
      cd - >/dev/null || exit
    fi
  done
  # update rust version
  rustup update
  # update cargo installs
  cargo install-update -a
  # update xmake
  xmake update
  # update nvim
  bob use latest
  # update nvm
  if __nvm_uptodate; then
    echo "nvm is already up to date at $LATEST_NVM_REMOTE"
  else
    echo "Installing nvm..."
    curl --silent -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$LATEST_NVM_REMOTE/install.sh" | bash > /dev/null 2>&1
    echo "Installed nvm"
  fi
  # update nvm
  nvm install node
  # if brew exists, update brew
  if __command_exists brew; then
    brew update
    brew upgrade
  fi
}
