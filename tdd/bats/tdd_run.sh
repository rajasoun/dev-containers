#!/usr/bin/env sh

docker run -it -v "${PWD}:/code" rajasoun/bats-with-helpers:latest  /code/test -t