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

###################################
# Function to display a choice    #
# Globals:                        #
#  None                           #
# Arguments:                      #
#   $1 is prompt                  #
#   $2 min answers required       #
#   $3 is a string separated by   #
#      spaces or \n for options   #
#   $4 return value (ref)         #
# Returns:                        #
#   list of selected options      #
###################################
__ask_choice() {
  subject="$1"
  min_answers=$2
  options="$(echo "$3" | tr '\n' ' ')"
  _outvar="$4"
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
    if [ -n "$msg" ]; then
      echo "$msg"
      msg=""
    fi
  }

  prompt="Check an option (again to uncheck, ENTER when done): "
  while __menu "$options" "$subject" && printf "%s" "$prompt" && read -r num; do
    case $num in
      "")
        if [ "$(echo "$answers" | awk '{print NF}')" -lt "$min_answers" ]; then
          msg="You need to select at least $min_answers option."
          continue
        else
          break
        fi
        ;;
      *[!0-9]*)
        msg="Invalid option: $num"
        continue
        ;;
      *)
        test "$num" -gt 0 -a "$num" -lt "$((length+1))" || {
          msg="Invalid option: $num"
          continue
        }
        ;;
    esac
    chosen=$(echo "$options" | awk -v n="$num" 'BEGIN{FS=" "}{print $n}')
    if echo "$answers" | grep -q "$chosen"; then
      # vvv SC3060 (warning): In POSIX sh, string replacement is undefined. vvv
      # shellcheck disable=SC2001
      answers=$(echo "$answers" | sed "s/ $chosen//g")
    else
      answers="$answers $chosen"
    fi
  done

  eval "$_outvar='$answers'"
}

