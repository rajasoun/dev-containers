include ../../make/Makefile

REGISTRY_HOST=$(REGISTRY_HOST_URL)
USERNAME=$(USER)
NAME=$(shell basename $(CURDIR))
DOCKER_BUILD_ARGS=--build-arg TAG_VERSION=$(VERSION)

# Referennce: https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html
.PHONY: help clean run shell
.DEFAULT_GOAL := help

##@ Build Management
build:   		## Build Docker File
release: 		## Release Docker Container to the Registry (default: docker.io)
patch-release:	## increments the patch release level, build and push to registry
minor-release:	## increments the minor release level, build and push to registry
major-release:	## increments the major release level, build and push to registry
snapshot:		## build from the current (dirty) workspace and pushes the image to the registry
check-status:	## will check whether there are outstanding changes
check-release:	## will check whether the current directory matches the tagged release in git.
showver:		## will show the current release tag based on the directory content

##@ Utility
help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make <action>\033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

clean: ## Tidy up local environment
	@find . -name ‘*.DS_Store’ -type f -delete
	@docker rmi $(IMAGE):$(VERSION) $(IMAGE):latest 2>/dev/null || echo "Container $(IMAGE):$(VERSION) not avilable"
