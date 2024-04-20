#!/bin/bash

# exit the script when an error occurs
set -e

# extract the path of the current script
SCRIPTS_PATH=$(dirname "$0")
KITTY_CONFIG_PATH="${HOME}/.config/kitty"

# check if the kitty config folder exist
if [ -d "${KITTY_CONFIG_PATH}" ]; then
  # copy files with confirmation to override
  cp -i ${SCRIPTS_PATH}/../.config/kitty/* ${HOME}/.config/kitty/
else
  echo "ERROR: kitty config folder ${KITTY_CONFIG_PATH} not found"
fi

