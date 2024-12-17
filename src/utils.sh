#!/usr/bin/env bash

# IF XDG_CONFIG_HOME is not set, use ~/.config/packeep/config.sh
CONFIGFILE=${XDG_CONFIG_HOME:-$HOME/.config}/pacmark/config.sh
source $CONFIGFILE 2>/dev/null

# If KEEPLISTFILE is not set, use XDG_CONFIG_HOME or ~/.config/pacmark/packages.list
KEEPLISTFILE=${KEEPLISTFILE:-${XDG_CONFIG_HOME:-$HOME/.config}/pacmark/packages.list}

function clean_pkg_file {
  # Remove comments, remove whitespace and remove empty lines, then sort
  sed -e 's/#.*$//' -e 's/[ \t]//g' -e '/^\s*$/d' $1 | sort
}

function compare_keep_installed {
  # Print only the packages with plus and minus signs
  diff -u <(clean_pkg_file $KEEPLISTFILE) <(pacman -Qqe | sort) | sed -n "/^[-+][^-+]/p"
}

function decl_not_installed {
  # Get KEEPLIST pkgs that are not installed (have to use same sorting because of hyphens)
  compare_keep_installed | sed -n '/^-/s/^-//p'
}

function installed_not_decl {
  # Get installed pkgs not in keeplist.
  compare_keep_installed | sed -n '/^+/s/^+//p'
}

function compare_keep_input {
  # Print only the packages with either in both files (space) or only in input (plus)
  diff -u <(clean_pkg_file $KEEPLISTFILE) <(echo $@ | tr ' ' '\n' | sort) | sed -n "/^[ +][^+]/p"
}

function input_not_decl {
  # Get input pkgs that are not in KEEPLIST
  compare_keep_input $@ | sed -n '/^+/s/^+//p'
}

function input_and_decl {
  # Get input pkgs that are in KEEPLIST
  compare_keep_input $@ | sed -n '/^ /s/^ //p'
}
