#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

install_softwares() {
  (install_rust && echo "Rust installed") || {
    echo "Failed to install rust"
  }
  (install_xmake && echo "xmake installed") || {
    echo "Failed to install xmake"
  }
  (install_sccache && echo "sccache installed") || {
    echo "Failed to install sccache"
    echo "Cargo is not installed"
  }
  (install_cargo_pkgs && echo "Cargo packages installed") || {
    echo "Failed to install cargo packages"
    echo "Cargo is not installed"
  }
  (install_node && echo "Node installed") || {
    echo "Failed to install rtx"
    echo "Rtx is not installed"
  }
  (install_nvim && echo "Nvim installed") || {
    echo "Failed to install nvim"
    echo "Bob is not installed"
  }
}

install_rust() {
  # quiet option doesn't seem to do much see https://github.com/rust-lang/rustup/issues/3350
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y -q
  # return error code of previous command
  return $?
}

install_xmake() {
  # cannot be quieter until https://github.com/xmake-io/xmake/issues/3714 is fixed
  curl -fsSL https://xmake.io/shget.text | bash 1>/dev/null
  # return error code of previous command
  return $?
}

install_sccache() {
  [ -x ~/.cargo/bin/cargo ] && return 1
  ~/.cargo/bin/cargo install -q sccache
  # return error code of previous command
  return $?
}

install_cargo_pkgs() {
  [ -x ~/.cargo/bin/cargo ] || return 1
  # shellcheck disable=SC2046,SC2086
  RUSTC_WRAPPER=~/.cargo/bin/sccache ~/.cargo/bin/cargo install --locked -q $CARGO_PKGS # cargo doesn't like quotes around `$CARGO_PKGS`
  # return error code of previous command
  return $?
}

install_node() {
  [ -x ~/.cargo/bin/rtx ] || return 1
  ~/.cargo/bin/rtx install node
  # return error code of previous command
  return $?
}

install_nvim() {
  [ -x ~/.cargo/bin/bob ] || return 1
  ~/.cargo/bin/bob use latest
  # return error code of previous command
  return $?
}
