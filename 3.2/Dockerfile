FROM baselibrary/baseimage:2.0.0
MAINTAINER ShawnMa <qsma@thoughtworks.com>

## Version
ENV PYTHON_MAJOR   3.2
ENV PYTHON_VERSION 3.2.6-2+xenial1

## Repository
RUN \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DB82666C &&\
  echo "deb http://ppa.launchpad.net/fkrull/deadsnakes/ubuntu xenial main" > /etc/apt/sources.list.d/python.list

## Packages
RUN \
  apt-get update &&\
  apt-get install -y python3.2=$PYTHON_VERSION python3.2-dev python-pip &&\
  rm -rf /var/lib/apt/lists/*

## Additional
RUN \
  pip install --upgrade pip

## Environments
ENV PYTHONIOENCODING UTF-8
