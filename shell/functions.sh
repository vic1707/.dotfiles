#!/bin/bash

# extract archives
ex() {
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
      *)           echo "'$1' cannot be extracted via ex()" >&2 ;;
    esac
  else
    echo "'$1' is not a valid file" >&2
  fi
}

# check if command exists, one version exit if not, the other is a boolean
# if $2 is provided, exit if command does not exist
__command_exists() {
  if command -v "$1" 1>/dev/null; then
    return 0
  elif type -p "$1" 1>/dev/null; then
    return 0
  elif hash "$1" 1>/dev/null; then
    return 0
  elif which "$1" 1>/dev/null; then
    return 0
  elif $1 --version 1>/dev/null; then
    return 0
  fi
  echo "Command $1 does not exist" >&2
  [[ -n "$2" ]] && exit 1
  return 1
}

# update all zsh plugins, cargo installs, etc
__update_all() {
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
  # update node
  rtx install node
  # if brew exists, update brew
  if __command_exists brew; then
    brew update
    brew upgrade
  fi
}
