#!/bin/zsh

. ./shell/common/functions.sh

# exit script if any function returns with non-zero status
trap 'exit' ERR

typeset -A REQS=(
  # "'...'" is required due to the following `eval` command
  ["apt"]=(
    ["update"]="'sudo apt update'"
    ["install"]="'sudo apt install'"
    ["upgrade"]="'sudo apt upgrade'"
    ["reqs"]="'curl build-essential cmake libssl-dev pkg-config'"
    ["sudo"]=1
  )
  ["brew"]=(
    ["update"]="'brew update'"
    ["install"]="'brew install'"
    ["upgrade"]="'brew upgrade'"
    ["reqs"]="'curl cmake pkg-config'"
    ["sudo"]=0
  )
)

#############################################
# Identify package manager                  #
# Globals:                                  #
#   REQS (provided above)                   #
# Arguments:                                #
#   None                                    #
# Returns:                                  #
#   echo package manager                    #
#   0 if successful                         #
#   1 if unsuccessful (will echo an error)  #
#############################################
identify_package_manager() {
  local UNAME=$(uname)
  if [ $UNAME = 'Darwin' ]; then
    if __command_exists brew; then
      echo "brew"
      return 0;
    else
      echo "Error: brew not installed" >&2
      exit 1;
    fi
  elif [ $UNAME = 'Linux' ]; then
    for PM_T in ${(k)REQS[@]}; do
      if __command_exists "$PM_T" 2>/dev/null; then
        echo "$PM_T"
        return 0;
      fi
    done
    echo "Error: No supported package manager found" >&2
    exit 1;
  else
    echo "Error: Unsupported OS" >&2
    exit 1;
  fi
}

PM=$(identify_package_manager)
eval typeset -A MAN=$REQS[$PM]
