#!/bin/bash

DEBUG="${IDE_DEBUG:-false}"
IMAGE_NAME="${IDE_IMAGE_NAME:-ide}"
IMAGE_VERSION="${IDE_IMAGE_VERSION:-latest}"
IMAGE_CMD="$@"
LOG_CMD="logger -t $1 -s"
WORKSPACE="${IDE_WORKSAPCE:-${HOME}/Repos}"
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

log_debug "FILE_TO_OPEN_VOLUME_OPTS=${FILE_TO_OPEN_VOLUME_OPTS}"
log_debug "IMAGE_CMD=${IMAGE_CMD}"

# for docker in docker (dnd)
# expose the docker unix socket to tcp localhost:2375 with socat
# https://github.com/docker/roadmap/issues/189
if [[ $(netstat -a -alnp tcp | grep LISTEN | grep 127.0.0.1.2375) ]]; then
  log_debug "socat exist, skipping..." 
else
  log_debug "starting socat"
  docker run -d --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -p 127.0.0.1:2375:2375 \
    alpine/socat:latest \
    TCP-LISTEN:2375,fork UNIX-CONNECT:/var/run/docker.sock > /dev/null
fi

docker run -it --rm \
	-u $(id -u ${USER}):$(id -g ${USER}) \
	-v ${HOME}/.gitconfig:${HOME}/.gitconfig \
	-v ${HOME}/.ssh/known_hosts:${HOME}/.ssh/known_hosts \
	-v ${HOME}/.local/state/zsh:${HOME}/.local/state/zsh \
	-v ${HOME}/.cache/gitstatus:${HOME}/.cache/gitstatus \
	-v ${HOME}/.local/state/nvim/sessions:${HOME}/.local/state/nvim/sessions \
	-v ${HOME}/.local/state/nvim/shada:${HOME}/.local/state/nvim/shada \
	-v ${WORKSPACE}:${WORKSPACE} \
  --mount type=bind,source=/run/host-services/ssh-auth.sock,target=/run/host-services/ssh-auth.sock \
  -e SSH_AUTH_SOCK=/run/host-services/ssh-auth.sock \
	${FILE_TO_OPEN_VOLUME_OPTS} \
	-e DISPLAY=host.docker.internal:0 \
	-w ${WORKSPACE} \
	--cap-add=SYS_PTRACE \
	--net=host \
	${IMAGE_NAME}:${IMAGE_VERSION} \
	${IMAGE_CMD}
