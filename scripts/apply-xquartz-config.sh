#!/bin/bash

# exit the script when an error occurs
set -e

# disable debug by default
DEBUG="${DEBUG:-false}"

# disable xterm to start automatically
defaults write org.xquartz.X11 app_to_run xterm

# make sure auth is enable
defaults write org.xquartz.X11 no_auth 0

# enable the tcp listener
defaults write org.xquartz.X11 nolisten_tcp 0

# print config
[ "${DEBUG}" == "true" ] && logger -t "$1" -s -p user.debug $(defaults read org.xquartz.X11)
