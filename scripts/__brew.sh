#!/bin/sh

install_brew() {
  if command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
}

install_brew_packages() {
  # shellcheck disable=SC2046,SC2086
  /opt/homebrew/bin/brew install $BREW_PKGS # brew doesn't like quotes around `$BREW_PKGS`
  return $?
}
