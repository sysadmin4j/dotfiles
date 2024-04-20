#!/bin/bash

IMAGE_NAME="${IDE_IMAGE_NAME:-ide}"
IMAGE_VERSION="${IDE_IMAGE_VERSION:-latest}"
IMAGE_CMD="$@"
DEBUG="${IDE_DEBUG:-false}"
LOG_CMD="logger -t $1 -s"
X11="${IDE_X11:-false}"
X11_COMMAND="xhost +localhost"

function log_debug () {
  if [ "${DEBUG}" == "true" ]; then
    ${LOG_CMD} -p user.debug "$@"
  fi
}

function log_err () {
  ${LOG_CMD} -p user.err "$@"
}

function load_x11() {
    log_debug "loading X11"
    ${X11_COMMAND}
}

# load X11 if enabled
[ "${X11}" == "true" ] && load_x11

# if nvim is the first script arg and there are more than one arg
if [ "$1" == "nvim" ] && [ "$#" -gt 1 ]; then
	IMAGE_CMD="nvim"
	shift
	for FILE_TO_OPEN in "$@"; do
    FILE_TO_OPEN_ABSOLUTE_PATH=$(readlink -f ${FILE_TO_OPEN})
		# check if the file exist
		if [ -f "${FILE_TO_OPEN_ABSOLUTE_PATH}" ]; then
			# adding the file to the volume options
			FILE_TO_OPEN_VOLUME_OPTS="-v ${FILE_TO_OPEN_ABSOLUTE_PATH}:${FILE_TO_OPEN_ABSOLUTE_PATH} ${FILE_TO_OPEN_VOLUME_OPTS}"
			IMAGE_CMD="$IMAGE_CMD ${FILE_TO_OPEN_ABSOLUTE_PATH}"
		else
      # log an error and quit if one of the files specified in argument(s) don't exist(s)
			log_err "File ${FILE_TO_OPEN} don't exist"
			exit 1
		fi
	done
fi

# log debugging informations
log_debug "FILE_TO_OPEN_VOLUME_OPTS=${FILE_TO_OPEN_VOLUME_OPTS}"
log_debug "IMAGE_CMD=${IMAGE_CMD}"

docker run -it --rm \
	-u $(id -u ${USER}):$(id -g ${USER}) \
	-v ${HOME}/.ssh:/home/${USER}/.ssh \
	-v ${HOME}/.gitconfig:/home/${USER}/.gitconfig \
	-v ${HOME}/.local/state/nvim/sessions:/home/${USER}/.local/state/nvim/sessions \
	-v ${HOME}/.local/state/nvim/shada:/home/${USER}/.local/state/nvim/shada \
	-v ${HOME}/Repos:/home/${USER}/Repos \
	${FILE_TO_OPEN_VOLUME_OPTS} \
	-e DISPLAY=host.docker.internal:0 \
	-w /home/${USER} \
	--cap-add=SYS_PTRACE \
	--net=host \
	${IMAGE_NAME}:${IMAGE_VERSION} \
	${IMAGE_CMD}
