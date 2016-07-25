# Using centos 7 version
FROM centos:centos7

MAINTAINER Jamie Moore <jbgmoore@gmail.com>

RUN yum update -y; yum clean all
#RUN yum install -y epel-release centos-release-scl-rh; yum clean all 
#RUN yum list golang*
RUN yum install -y git; yum clean all

#Install Go
RUN curl -O  https://storage.googleapis.com/golang/go1.6.3.linux-amd64.tar.gz; tar -C /usr/local -xzf go1.6.3.linux-amd64.tar.gz; rm go1.6.3.linux-amd64.tar.gz
RUN mkdir -p /go/src/github.com/jamiemoore/gex
ENV GOPATH "/go" 
ENV PATH $PATH:/usr/local/go/bin:/go/bin

# Install a Go linter
RUN go get -u github.com/golang/lint/golint

# Cache deps in the Docker file for build speed
RUN go get -u github.com/gorilla/mux 

WORKDIR /go/src/github.com/jamiemoore/gex 
CMD ["/bin/bash"]
