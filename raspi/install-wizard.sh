#!/bin/sh

main() {
  local SHOULD_SETUP_OPTIOONAL
  local SHOULD_SETUP_KIOSK

  read_val "Install optional utils? [y/n]" SHOULD_SETUP_OPTION
  read_val "Install chromium kiosk? [y/n]" SHOULD_SETUP_KIOSK
  
  ./install-git-vim.sh
  ./first-upgrade.sh
  ./install-nvm.sh
  if [[ $SHOULD_SETUP_OPTION == 'y' ]]; then
    ./install-optional-utils.sh
  fi
  if [[ $SHOULD_SETUP_KIOSK == 'y' ]]; then
    ./kiosk/kiosk-purge-install.sh
  fi
}

read_val() {
  if [[ ! -z $2 ]]; then
    local val
    read -p "$1 " val
    eval "$2='${val}'"
  fi
}

main