FROM baselibrary/ubuntu:14.04
MAINTAINER ShawnMa <qsma@thoughtworks.com>

## Version
ENV PYTHON_MAJOR 2.7
ENV PYTHON_VERSION 2.7.5-5ubuntu3

## Repository
RUN \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DB82666C &&\
  echo "deb http://ppa.launchpad.net/fkrull/deadsnakes/ubuntu trusty main" > /etc/apt/sources.list.d/python.list

## Packages
RUN \
  apt-get update && \
  apt-get install -y python=$PYTHON_VERSION python$PYTHON_MAJOR-dev python-pip &&\
  rm -rf /var/lib/apt/lists/*

## Additional
RUN \
  pip install --upgrade pip

