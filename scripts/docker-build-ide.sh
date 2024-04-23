#!/bin/bash

IMG_USERNAME="${IDE_USERNAME:-felix}"
IMG_GROUPNAME="${IDE_GROUPNAME:-staff}"
IMG_UID="${IDE_UID:-501}"
IMG_GID="${IDE_GID:-20}"

cd $(dirname $0)/..

docker build \
  --build-arg="USERNAME=${IMG_USERNAME}" \
  --build-arg="GROUPNAME=${IMG_GROUPNAME}" \
  --build-arg="UID=${IMG_UID}" \
  --build-arg="GID=${IMG_GID}" \
  -t ide:latest .
