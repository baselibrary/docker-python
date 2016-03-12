## ThoughtWorks Docker Image: python

[![](http://dockeri.co/image/baselibrary/python)](https://registry.hub.docker.com/u/baselibrary/python/)

### Base Docker Image

* `latest`: python 3.5
* `3.5`   : python 3.5
* `3.4`   : python 3.4
* `3.3`   : python 3.3
* `3.2`   : python 3.2
* `3.1`   : python 3.1
* `2.7`   : python 2.7

### Installation

    docker pull baselibrary/python

### Usage

    docker run -it --rm baselibrary/python

    `
    FROM python:3.4

    RUN \
      pip install ...

    `
