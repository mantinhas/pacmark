#!/usr/bin/env bash

SHRDIR=$(dirname $BASH_SOURCE)
source $SHRDIR/utils.sh

function clean {

  # If file does not exist abort
  if [ ! -f $KEEPLISTFILE ]; then
    echo "File packages.list does not exist. Aborting..." >&2
    exit 1
  fi
  # Remove packages not in KEEPLISTFILE
  # Save packages list into string, not run command
  INSTALLEDNOTDECL=$(installed_not_decl | xargs)

  if [[ -n $INSTALLEDNOTDECL ]]; then
    echo -e "The following $(echo $INSTALLEDNOTDECL | wc -w) package(s) are strayed (installed but not declared in packages.list):\n\t$INSTALLEDNOTDECL"
    echo -e "Uninstalling..."
    echo $INSTALLEDNOTDECL | xargs sudo pacman -Rns --noconfirm > /dev/null
  else 
    echo "There are no stray packages. Nothing to remove."
  fi

  # Install packages in KEEPLISTFILE
  DECLNOTINST=$(decl_not_installed | xargs)

  if [[ -n $DECLNOTINST ]]; then
    echo -e "The following $(echo $DECLNOTINST | wc -w) package(s) are missing (declared in packages.list but not installed):\n\t$DECLNOTINST"
    echo -e "Installing..."
    echo $DECLNOTINST | xargs sudo pacman -S --noconfirm > /dev/null
  else
    echo "There are no missing packages. Nothing to install."
  fi
}
