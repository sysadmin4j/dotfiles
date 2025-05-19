#!/bin/bash

IMG_USERNAME="${IDE_USERNAME:-felix}"
IMG_GROUPNAME="${IDE_GROUPNAME:-staff}"
IMG_UID="${IDE_UID:-501}"
IMG_GID="${IDE_GID:-20}"
IMG_HOME_DIR="${IDE_HOME_DIR:-/Users/${IMG_USERNAME}}"

cd $(dirname $0)/..

docker buildx build \
  --build-arg="USERNAME=${IMG_USERNAME}" \
  --build-arg="GROUPNAME=${IMG_GROUPNAME}" \
  --build-arg="UID=${IMG_UID}" \
  --build-arg="GID=${IMG_GID}" \
  --build-arg="HOME_DIR=${IMG_HOME_DIR}" \
  -t ide:latest .
