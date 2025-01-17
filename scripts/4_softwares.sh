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
	# requires bash
	if ! command -v bash > /dev/null 2>&1; then
		echo "bash is required to install xmake"
		return 1
	fi
	XMAKE_QUIET="$(if [ "$QUIET" = "-q" ]; then echo '1>/dev/null'; else echo ""; fi)"
	# cannot be quieter because https://github.com/xmake-io/xmake/issues/3714
	# TODO: bash is used
	bash -c "$(curl -fsSL https://xmake.io/shget.text) $XMAKE_QUIET"
	# return error code of previous command
	return $?
}

install_cargo_pkgs() {
	# shellcheck disable=SC2086 # cargo doesn't like quotes around `$QUIET` and `$CARGO_PKGS`
	~/.cargo/bin/cargo install --locked $QUIET $CARGO_PKGS
	# return error code of previous command
	return $?
}
