#!/usr/bin/env bash

set -x

cat ./docker_image_lists.txt | awk '{print ""$1""}' | awk '{print "docker pull "$1""}' | sh
