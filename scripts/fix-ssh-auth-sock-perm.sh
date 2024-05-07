#!/bin/bash
# this script is used to fix the permissions of /run/host-services/ssh-auth.sock, to be able to use the socket as a non-root USER
# the permissions change will affect all the containers of the host, and must be executed after a docker service restart
# here are the default permissions of the socket
# ❯ ls -al /run/host-services/ssh-auth.sock
# srw-rw---- 1 root root 0 May  6 22:28 /run/host-services/ssh-auth.sock
# Ref:
# - https://docs.docker.com/desktop/networking/#ssh-agent-forwarding
# TODO:
# - move this script to docker-run-ide.sh

IMAGE_NAME="${IDE_IMAGE_NAME:-ide}"
IMAGE_VERSION="${IDE_IMAGE_VERSION:-latest}"

SSH_AUTH_SOCK="/run/host-services/ssh-auth.sock"
IMAGE_CMD="chown $(id -u ${USER}):$(id -g ${USER}) ${SSH_AUTH_SOCK}"

docker run -it --rm -u root \
  --mount type=bind,source=${SSH_AUTH_SOCK},target=${SSH_AUTH_SOCK} \
	${IMAGE_NAME}:${IMAGE_VERSION} \
	${IMAGE_CMD}
