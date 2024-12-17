#!/usr/bin/env bash

SHRDIR=$(dirname $BASH_SOURCE)
source $SHRDIR/utils.sh

function mark {
  ADDED_MESSAGE="$USER - $(date)"

  if (( $(input_and_decl $@ | wc -l) > 0 )); then
    echo -e "Packages already marked:\n\t$(input_and_decl $@ | xargs)"
  fi

  if (( $(input_not_decl $@ | wc -l) > 0 )); then
    echo -e "Marking packages:\n\t$(input_not_decl $@ | xargs)"
    input_not_decl $@ | sed "s/$/ # $ADDED_MESSAGE/g" >> $KEEPLISTFILE
  else
    echo "No packages to mark."
  fi
}

#function unmark {
#  # WIP
#}
