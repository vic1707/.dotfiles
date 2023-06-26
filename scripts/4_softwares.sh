#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

install_rust() {
  # quiet option doesn't seem to do much see https://github.com/rust-lang/rustup/issues/3350
  # shellcheck disable=SC2086 # rustup doesn't like quotes around `$QUIET`
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y $QUIET
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
  # shellcheck disable=SC2086 # cargo doesn't like quotes around `$QUIET`
  ~/.cargo/bin/cargo install $QUIET sccache
  # return error code of previous command
  return $?
}

install_cargo_pkgs() {
  # shellcheck disable=SC2086 # cargo doesn't like quotes around `$QUIET` and `$CARGO_PKGS`
  RUSTC_WRAPPER=~/.cargo/bin/sccache ~/.cargo/bin/cargo install --locked $QUIET $CARGO_PKGS
  # return error code of previous command
  return $?
}

install_node() {
  ~/.cargo/bin/rtx install node
  # return error code of previous command
  return $?
}

install_nvim() {
  ~/.cargo/bin/bob use latest
  # return error code of previous command
  return $?
}
