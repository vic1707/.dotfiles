#!/bin/sh

###################################
## This script needs to be POSIX ##
###################################

#############################################
# Extract a given archive if possible       #
# Globals:                                  #
#   None                                    #
# Arguments:                                #
#   $1: archive to extract                  #
# Returns:                                  #
#   0 if archive is extracted               #
#   1 if archive is not extracted           #
# Stderr:                                   #
#   Error message if $1 is not a valid file #
#############################################
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
      *)           echo "'$1' cannot be extracted via ex()" >&2; return 1 ;;
    esac
  else
    echo "'$1' is not a valid file" >&2
    return 1
  fi
  return 0
}

#############################################
# Check if a command exists                 #
# Globals:                                  #
#   None                                    #
# Arguments:                                #
#   $1: command to check                    #
#   $2: exit if command does not exist      #
# Returns:                                  #
#   0 if command exists                     #
#   1 if command does not exist             #
#############################################
__command_exists() {
  if command -v "$1" 1>/dev/null; then
    return 0
  fi
  echo "Command $1 does not exist" >&2
  [ -n "$2" ] && exit 1
  return 1
}
