#!/bin/bash
# TODO:
# adding build arg
cd $(dirname $0)/..
docker build -t ide:latest .
