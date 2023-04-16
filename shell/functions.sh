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
function __command_exists_f() {
  if ! command -v "$1" &> /dev/null; then
    echo "Error: $1 is not installed (command)"
    exit 1
  fi
  if ! type "$1" &> /dev/null; then
    echo "Error: $1 is not installed (type)"
    exit 1
  fi
  if ! hash "$1" &> /dev/null; then
    echo "Error: $1 is not installed (hash)"
    exit 1
  fi
}

function __command_exists_b() {
  if ! command -v "$1" &> /dev/null; then
    return 1
  fi
  if ! type "$1" &> /dev/null; then
    return 1
  fi
  if ! hash "$1" &> /dev/null; then
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
      cd - || exit
    fi
  done
  # update cargo installs
  cargo install "$(cargo install --list | grep -E '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ')"
  # update nvim
  bob use latest
  # update nvm
  nvm install node
}
