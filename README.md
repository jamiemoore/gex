# Gex - Go Example Project
[![Build Status](https://travis-ci.org/jamiemoore/gex.svg?branch=master)](https://travis-ci.org/jamiemoore/gex)

This is a Golang "Hello World" example project.

## Installation
You can install Gex using the following methods.

### Run using the default docker daemon
  * Set an environment variable to match your current environment (or any arbitrary text) ``` export GEXENV=dev```
  * Lint, Build, test and Run using docker with command: ```make```

## Usage
Now that Gex is running and your environment variable is set. You will be able to see the following output from curl

  * See the current Gex webpage.

    ```
    curl localhost:8080
    ```

  * Using the API to get the message

    ```
    curl -s localhost:8080/api/message | jq -r '.message'
    ```
    * Using the API to get the version

    ```
    curl -s localhost:8080/api/version | jq -r '.version'
    ```


## Building

### Requirements
An environment variable needs to be provided for the

  * Docker
  * Make
  * environment variable ``` export GEXENV=dev```

Note that Golang is not required as building and unit tests are run from within a docker image.

### Build
Note that you do not have to have golang installed on your system as the binary is built using a docker container.  Build using the following commands

```
make build
```

### Test (Functional)
Test using the following commands

```
make test
```
### Upload to the docker repository
* add a new annotated git tag using [semver](http://semver.org/) ```git tag -a -m "description" v[major].[minor].[patch]``` if you have not done so already
* Either use ```docker login``` or set the environment variables matching the docker hub account
```
export DOCKER_EMAIL=
export DOCKER_USERNAME=
export DOCKER_PASSWORD=
```
* upload to your docker repository ```make upload```

### List of make commands
  * ```make``` - lint, build, unittest, test and run
  * ```make lint``` - format and lint the code
  * ```make build``` - compile the go code in it's own docker container
  * ```make unittest``` - run the unit tests
  * ```make run``` - runs Gex in the runtime docker container.
  * ```make integrationtest``` - runs the integration tests
  * ```make uitest``` - runs the ui tests
  * ```make test``` - runs the integrationtest and uitest
  * ```make upload``` - upload the latest docker runtime to the docker registry
  * ```make docker-build``` - create the docker image used for Building
  * ```make docker-runtime``` - create the docker runtime image used for running Gex
  * ```make pipeline``` - run by the pipeline to upload, deploy and check
  * ```make deploy-sloppy``` - deploy from docker hub to sloppy io
  * ```make rollback-sloppy``` - rollback to the previous release
  * ```make post-deploy-check-sloppy``` confirm the new version is available at http://gex.sloppy.zone


## Deployment
Please note that there is no latest version to run a specific version must be selected.

### Requirements
  * System with the docker daemon running
  * Access to the docker repository (docker hub)
  * Upload your docker image as per the process above

### Installation
  * on the virtual machine which is currently running docker run the following command, selecting the correct version.

  ```
  docker rm --force gex ; docker run -d --restart=always -p 8080:8080 -e GEXENV=prod --name gex jamie/gex:v[major].[minor].[patch]
  ```

I would suggest running under a clustering technology, such as kubernetes  Installation would vary in this case, depending upon the technology chosen.
