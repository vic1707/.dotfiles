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

###################################
# Function to display a choice    #
# Globals:                        #
#  None                           #
# Arguments:                      #
#   $1 is prompt                  #
#   $2 is a string separated by   #
#      spaces or \n for options   #
#   $3 return value (ref)         #
# Returns:                        #
#   list of selected options      #
###################################
__ask_multi_choice() {
  subject="$1"
  options="$(echo "$2" | tr '\n' ' ')"
  _outvar="$3"
  length=$(echo "$options" | awk '{print NF}')
  answers=""

  __menu() {
    echo "$2"
    idx=1
    for i in $1; do
      is_selected=$(echo "$answers" | grep -c "$i")
      if [ "$is_selected" -eq 1 ]; then
        echo "$idx+) $i"
      else
        echo "$idx ) $i"
      fi
      idx=$((idx+1))
    done
    if [ -n "$msg" ]; then echo "$msg"; fi
  }

  prompt="Check an option (again to uncheck, ENTER when done): "
  while __menu "$options" "$subject" && printf "%s" "$prompt" && read -r num && test -n "$num"; do
    case $num in
      *[!0-9]* | "")
        msg="Invalid option: $num"
        continue
        ;;
      *)
        test "$num" -gt 0 -a "$num" -lt "$((length+1))" || {
          msg="Invalid option: $num"
          continue
        } ;;
    esac

    chosen=$(echo "$options" | awk -v n="$num" 'BEGIN{FS=" "}{print $n}')
    if echo "$answers" | grep -q "$chosen"; then
      answers=$(echo "$answers" | sed "s/$chosen//g")
    else
      answers="$answers $chosen"
    fi
  done

  eval "$_outvar='$answers'"
}

###################################
# Function to display a choice    #
# Globals:                        #
#  None                           #
# Arguments:                      #
#   $1 is prompt                  #
#   $2 is a string separated by   #
#      spaces or \n for options   #
#   $3 return value (ref)         #
# Returns:                        #
#   selected option               #
###################################
__ask_unique_choice() {
  subject="$1"
  options="$(echo "$2" | tr '\n' ' ')"
  _outvar="$3"
  length=$(echo "$options" | awk '{print NF}')
  answer=""

  __menu() {
    echo "$2"
    idx=1
    for i in $1; do
      echo "$idx ) $i"
      idx=$((idx+1))
    done
    if [ -n "$msg" ]; then echo "$msg"; fi
  }

  prompt="Check an option (again to uncheck, ENTER when done): "
  while __menu "$options" "$subject" && printf "%s" "$prompt" && read -r num && test -n "$num"; do
    case $num in
      *[!0-9]* | "")
        msg="Invalid option: $num";
        continue ;;
      *)
        test "$num" -gt 0 -a "$num" -lt "$((length+1))" || {
          msg="Invalid option: $num";
          continue;
        } ;;
    esac

    answer=$(echo "$options" | awk -v n="$num" 'BEGIN{FS=" "}{print $n}')
    break
  done

  eval "$_outvar='$answer'"
}
