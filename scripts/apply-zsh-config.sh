#!/bin/bash

# exit the script when an error occurs
set -e

# create the folder used to store the history file
mkdir -p ${HOME}/.local/state/zsh

# extract the path of the current script
SCRIPTS_PATH=$(dirname "$0")

# copy files with confirmation to override
cp -i ${SCRIPTS_PATH}/../.zshrc.macos ${HOME}/.zshrc
