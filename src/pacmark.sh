#!/bin/bash

source ~/.local/lib/pacmark/utils.sh 

function show_help {
  echo "Usage: pacmark [command] [args]"
  echo "Commands:"
  echo "  clean                 Reset state to declared"
  echo "  diff                  Show diff between declared state and actual state"
  echo "  generate              Generate a new packages.list file"
  echo "  list                  List all marked (declared) packages"
  echo "  status pkg1 pkg2 ...  Show the status of a package (marked, installed, or both)"
  echo "  mark pkg1 pkg2 ...    Mark the specified packages as permanent"
  echo "  unmark pkg1 pkg2 ...  [WIP] Unmark the specified packages, making them removable"
  echo "  --help, -h            Show this help message"
}

if [[ $# -eq 0 ]]; then
  show_help
  exit 1
fi

command=$1
shift

case $command in
  clean)
    source ~/.local/lib/pacmark/clean.sh
    clean
    ;;
  diff)
    compare_keep_installed
    ;;
  mark)
    if [[ $# -eq 0 ]]; then
        echo "Error: No packages specified to mark."
        exit 1
    fi
    source ~/.local/lib/pacmark/mark.sh
    mark $@
    ;;
  unmark)
    #if [[ $# -eq 0 ]]; then
    #    echo "Error: No packages specified to unmark."
    #    exit 1
    #fi
    #source ~/.local/lib/pacmark/mark.sh 
    #unmark $@
    echo "Error: Unmark command is not yet implemented."
    ;;
  status)
    if (( $# == 0 )); then
      echo "Error: No package specified to check status."
      exit 1
    fi
    source ~/.local/lib/pacmark/status.sh
    status $@
    ;;
  generate)
    source ~/.local/lib/pacmark/generate.sh
    generate
    ;;
  list)
    clean_pkg_file $KEEPLISTFILE
    ;;
  --help|-h)
    show_help
    ;;
  *)
    echo "Error: Unknown command '$command'"
    show_help
    exit 1
    ;;
esac
