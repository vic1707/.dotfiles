#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

SUPPORTED_PM="brew apt apt-get"
export SUPPORTED_PM

##############
##   Cargo  ##
##############
CARGO_PKGS="
bacon
bat
bob-nvim
bottom
cargo-edit
cargo-leptos
cargo-update
coreutils
diskonaut
du-dust
exa
flamegraph
gitui
git-delta
hyperfine
nu
procs
ripgrep
rtx-cli
starship
"

##############
## Homebrew ##
##############
BREW_PKGS="
ffmpeg
fzf
imagemagick
openssh
tmux
tree
rsteube/tap/carapace
android-platform-tools
"

##############
##    Apt   ##
##############
APT_PKGS="
adb
ffmpeg
fzf
imagemagick
openssh-client
passwd
tmux
tree
"

export CARGO_PKGS
export BREW_PKGS
export APT_PKGS
