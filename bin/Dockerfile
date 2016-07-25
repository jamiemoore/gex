# Using centos 7 version
FROM centos:centos7

MAINTAINER Jamie Moore <jbgmoore@gmail.com>

RUN yum update -y; yum clean all

ADD gex /usr/local/bin/

EXPOSE 8080

CMD ["/usr/local/bin/gex"]
