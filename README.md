# Gex - Go Example Project
This is a Golang "Hello World" example project.

## Installation
You can install Gex using the following methods.

### Local Installation into /usr/local/bin
  * Build and install gex with ```make install```  
  * Set an environment variable to match your current environment (or any arbitory text) ``` export GEXENV=prod```
  * Run gex ```./gex```

### Run using the default docker daemon
  * Build, Test and Run using docker with ```make```

### Run from Supervisord (Recommended for long lived installs)
Any process monitoring software could be used, this is just an example using Supervisord

## Usage
Now that Gex is running and your environment variable is set. You will be able to see the following output from curl

  * See the current Gex webpage.

    ```
    curl yourhost
    ```

  * Request from the API

    ```
    curl yourhost/api/get/web_message
    ```

## Build Requirements
An environment variable needs to be provided for the

  * Docker
  * Make
  * environment variable ``` export GEXENV=prod```

Note that Golang is not required as building and unit tests are run from within a docker image.

## Build
Build using the following commands

```
make build
```

## Test (Functional)
Test using the following commands

```
make test
```
