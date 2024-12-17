#!/usr/bin/env bash

source ~/.local/lib/pacmark/utils.sh

function status_aux {
  # Is marked
  if pacman -Qqe $1 &>/dev/null; then
    echo "marked: yes"
  else 
    echo "marked: no"
  fi

  # Is installed
  if grep -E "^$1$" $KEEPLISTFILE &>/dev/null; then
    echo "installed: yes"
  else
    echo "installed: no"
  fi
}


function status {
  if (( $# > 1 )); then
    while (( $# > 0 )); do
      echo -e "$1"
      status_aux $1
      shift
    done
  else
    status_aux $1
  fi
}
