#!/bin/bash

# exit the script when an error occurs
set -e

# extract the path of the current script
SCRIPTS_PATH=$(dirname "$0")

# create the default kitty search path
IDE_BIN_PATH="${HOME}/.local/bin"
mkdir -p ${IDE_BIN_PATH}

# copy the runner script to ide bin path
cp ${SCRIPTS_PATH}/docker-run-ide.sh ${IDE_BIN_PATH}/ide
