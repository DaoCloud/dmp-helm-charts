SHELL := /bin/bash -o pipefail

export SCRIPT_ROOT := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: image.pull

# pull es, mysql,redis,dmp image
image.pull:
	cd $(SCRIPT_ROOT)/scripts/ && ./pull_image.sh
