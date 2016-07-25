###############################################################################
# Makefile - Gex
###############################################################################

SRC := $(CURDIR)
DOCKER_BUILD_IMAGE := jamie/gex_build
DOCKER_BUILD_DIR := $(SRC)/build
DOCKER_BUILD_CONTAINER_DIR := /go/src/github.com/jamiemoore/gex

DOCKER_RUN_DIR := $(SRC)/bin
DOCKER_RUN_IMAGE := jamie/gex

LATEST_GIT_TAG := $(shell git describe)

.PHONY: all
all: lint build unittest test run

.PHONY: upload
upload: test
	@echo ""
	@echo "################################################################################"                                                                                         
	@echo "# uploading to registry..."
	@echo "################################################################################"                                                                                         
	@echo "" 
	@docker push $(DOCKER_RUN_IMAGE):$(LATEST_GIT_TAG)  

.PHONY: build
build: lint
	@echo ""
	@echo "################################################################################"                                                                                         
	@echo "# building..."
	@echo "################################################################################"                                                                                         
	@echo "" 
	@docker run --rm -v $(SRC):$(DOCKER_BUILD_CONTAINER_DIR) $(DOCKER_BUILD_IMAGE) $(DOCKER_BUILD_CONTAINER_DIR)/build/build.sh  

.PHONY: lint
lint: docker-build
	@echo ""
	@echo "################################################################################"                                                                                         
	@echo "# linting..."
	@echo "################################################################################"                                                                                         
	@echo "" 
	@docker run --rm -v $(SRC):$(DOCKER_BUILD_CONTAINER_DIR) $(DOCKER_BUILD_IMAGE) $(DOCKER_BUILD_CONTAINER_DIR)/build/lint.sh  

.PHONY: unittest 
unittest: build
	@echo ""                                                                                                                                                                         
	@echo "################################################################################"                                                                                         
	@echo "# unit tests..."
	@echo "################################################################################"                                                                                         
	@echo "" 
	@docker run --rm -v $(SRC):$(DOCKER_BUILD_CONTAINER_DIR) $(DOCKER_BUILD_IMAGE) $(DOCKER_BUILD_CONTAINER_DIR)/build/unittest.sh  

.PHONY: test 
test: integrationtest uitest

.PHONY: integrationtest 
integrationtest: docker-runtime 
	@echo ""                                                                                                                                                                         
	@echo "################################################################################"                                                                                         
	@echo "# integration tests..."
	@echo "################################################################################"                                                                                         
	@echo "" 
	echo "TODO: Add integration tests"

.PHONY: uitest 
uitest: docker-runtime 
	@echo ""                                                                                                                                                                         
	@echo "################################################################################"                                                                                         
	@echo "# ui tests..."
	@echo "################################################################################"                                                                                         
	@echo "" 
	echo "TODO: Add ui tests"

.PHONY: run
run: check-env build docker-runtime
	@echo ""                                                                                                                                                                         
	@echo "################################################################################"                                                                                         
	@echo "# running..."
	@echo "################################################################################"                                                                                         
	@echo "" 
	@docker run --rm -e GEXENV=${GEXENV} -p 8080:8080 $(DOCKER_RUN_IMAGE)

.PHONY: check-env
check-env: 
	@echo ""                                                                                                                                                                         
	@echo "################################################################################"                                                                                         
	@echo "# checking env..."
	@echo "################################################################################"                                                                                         
	@echo "" 

ifndef GEXENV
	$(error GEXENV is undefined)
endif

.PHONY: docker-build
docker-build: 
	@echo ""                                                                                                                                                                         
	@echo "################################################################################"                                                                                         
	@echo "# building docker build image..."
	@echo "################################################################################"                                                                                         
	@echo "" 
	@docker build $(DOCKER_BUILD_ARGS) -t $(DOCKER_BUILD_IMAGE) $(DOCKER_BUILD_DIR)

.PHONY: docker-runtime
docker-runtime: 
	@echo ""                                                                                                                                                                         
	@echo "################################################################################"                                                                                         
	@echo "# building docker runtime image..."
	@echo "################################################################################"                                                                                         
	@echo "" 
	@docker build $(DOCKER_RUN_ARGS) -t $(DOCKER_RUN_IMAGE) $(DOCKER_RUN_DIR)
	@docker tag $(DOCKER_RUN_IMAGE) $(DOCKER_RUN_IMAGE):$(LATEST_GIT_TAG)

