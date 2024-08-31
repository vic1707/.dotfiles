#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

###################################
# Tries to find a supported       #
# package manager                 #
# Globals:                        #
#   SUPPORTED_PM                  #
# Arguments:                      #
#   None                          #
# Returns:                        #
#   0 if a supported package      #
#     manager was found (echo it) #
#   1 if no supported package     #
#     manager was found           #
###################################
find_package_manager() {
	for PM in $SUPPORTED_PM; do
		if command -v "$PM" > /dev/null 2>&1; then
			echo "$PM"
			return 0
		fi
	done
	echo "Error: No supported package manager found" >&2
	exit 1
}

###################################
# Prints the commands to update,  #
# install, upgrade or install     #
# requirements for a package      #
# manager                         #
# Globals:                        #
#   SUDO_PREFIX                   #
#   QUIET                         #
# Arguments:                      #
#   $1: package manager           #
#   $2: command                   #
#   $3: additionnal packages      #
#        if $2 is `install`       #
# Returns:                        #
#   0 if a supported command & PM #
#     was passed                  #
#   1 if unsupported package      #
#     manager or command          #
#     was passed                  #
###################################
PM_commands() {
	case $1 in
		##############
		## Homebrew ##
		##############
		brew)
			case $2 in
				update)
					# shellcheck disable=SC2086
					brew update $QUIET
					return $?
					;;
				install)
					# shellcheck disable=SC2086
					brew install $QUIET $3
					return $?
					;;
				upgrade)
					# shellcheck disable=SC2086
					brew upgrade $QUIET
					return $?
					;;
				install-reqs)
					# openssl: Required to install many rust packages
					# shellcheck disable=SC2086
					brew install $QUIET openssl
					return $?
					;;
				install-additionnal)
					# shellcheck disable=SC2086
					if ! brew install $QUIET $BREW_PKGS || ! additionnal_brew_installs; then
						return 1
					fi
					return 0
					;;
				*)
					echo "Error: Unsupported command" >&2
					exit 1
					;;
			esac
			;;
			###########
			##  APT  ##
			###########
		apt | apt-get)
			APT_QUIET="$(if [ "$QUIET" = "-q" ]; then echo "-q -qq"; else echo ""; fi)"
			case $2 in
				update)
					# shellcheck disable=SC2086
					$SUDO_PREFIX apt $APT_QUIET update
					return $?
					;;
				install)
					# shellcheck disable=SC2086
					$SUDO_PREFIX apt $APT_QUIET -y install $3
					return $?
					;;
				upgrade)
					# shellcheck disable=SC2086
					$SUDO_PREFIX apt $APT_QUIET -y upgrade
					return $?
					;;
				install-reqs)
					# build-essential
					# cmake
					# curl
					# libssl-dev, pkg-config: rust `openssl-sys` crate
					# shellcheck disable=SC2086
					$SUDO_PREFIX apt $APT_QUIET -y install build-essential cmake curl libssl-dev pkg-config
					return $?
					;;
				install-additionnal)
					# shellcheck disable=SC2086
					if ! $SUDO_PREFIX apt $APT_QUIET -y install $APT_PKGS || ! additionnal_apt_installs; then
						return 1
					fi
					return 0
					;;
				*)
					echo "Error: Unsupported command" >&2
					exit 1
					;;
			esac
			;;
		*)
			echo "Error: Unsupported package manager" >&2
			exit 1
			;;
	esac
}
