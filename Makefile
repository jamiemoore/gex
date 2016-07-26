###############################################################################
# Makefile - Gex
###############################################################################

SRC := $(CURDIR)
DOCKER_BUILD_IMAGE := jamie/gex_build
DOCKER_BUILD_DIR := $(SRC)/build
DOCKER_BUILD_CONTAINER_DIR := /go/src/github.com/jamiemoore/gex

DOCKER_RUN_IMAGE := jamie/gex

LATEST_GIT_TAG := $(shell git describe)

.PHONY: all
all: lint build unittest test run

.PHONY: lint
lint: docker-build
	@echo ""
	@echo "################################################################################"                                                                                         
	@echo "# formatting and linting..."
	@echo "################################################################################"                                                                                         
	@echo "" 
	@docker run --rm -v $(SRC):$(DOCKER_BUILD_CONTAINER_DIR) $(DOCKER_BUILD_IMAGE) $(DOCKER_BUILD_CONTAINER_DIR)/build/lint.sh  


.PHONY: build
build: lint
	@echo ""
	@echo "################################################################################"                                                                                         
	@echo "# building..."
	@echo "################################################################################"                                                                                         
	@echo "" 
	@if [ -e bin/gex ]; then echo "deleting existing artifact"; rm bin/gex; fi;
	@docker run --rm -v $(SRC):$(DOCKER_BUILD_CONTAINER_DIR) $(DOCKER_BUILD_IMAGE) $(DOCKER_BUILD_CONTAINER_DIR)/build/build.sh
	@if [ -e bin/gex ]; then echo "build successful!"; else echo "BUILD FAILED!"; exit 1; fi;

.PHONY: unittest 
unittest: build
	@echo ""                                                                                                                                                                         
	@echo "################################################################################"                                                                                         
	@echo "# unit tests..."
	@echo "################################################################################"                                                                                         
	@echo "" 
	@docker run --rm -v $(SRC):$(DOCKER_BUILD_CONTAINER_DIR) $(DOCKER_BUILD_IMAGE) $(DOCKER_BUILD_CONTAINER_DIR)/build/unittest.sh  

.PHONY: test 
test: unittest integrationtest uitest

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

.PHONY: upload
upload: test
	@echo ""
	@echo "################################################################################"                                                                                         
	@echo "# if release is tagged, uploading to registry..."
	@echo "################################################################################"                                                                                         
	@echo "" 
	#We only upload when the release is tagged
	@git describe --exact-match HEAD >/dev/null 2>&1 ; if [ $$? -eq 0 ] ; then docker push $(DOCKER_RUN_IMAGE):$(LATEST_GIT_TAG) ; else echo "Release is not tagged, not uploading"; fi

.PHONY: docker-build
docker-build: 
	@echo ""                                                                                                                                                                         
	@echo "################################################################################"                                                                                         
	@echo "# building docker build image..."
	@echo "################################################################################"                                                                                         
	@echo "" 
	@docker build -t $(DOCKER_BUILD_IMAGE) $(DOCKER_BUILD_DIR)

.PHONY: docker-runtime
docker-runtime: 
	@echo ""                                                                                                                                                                         
	@echo "################################################################################"                                                                                         
	@echo "# building docker runtime image..."
	@echo "################################################################################"                                                                                         
	@echo "" 
	@docker build -t $(DOCKER_RUN_IMAGE) $(SRC)
	@docker tag $(DOCKER_RUN_IMAGE) $(DOCKER_RUN_IMAGE):$(LATEST_GIT_TAG)

