NAME     = baselibrary/python
REPO     = git@github.com:baselibrary/docker-python.git
LOCAL    = 192.168.99.2
VERSIONS = $(foreach df,$(wildcard */Dockerfile),$(df:%/Dockerfile=%))

all: build

build: $(VERSIONS)

update:
	docker run --rm -v $$(pwd):/work -w /work buildpack-deps ./update.sh

.PHONY: all build library $(VERSIONS)
$(VERSIONS):
	docker build --rm --tag=$(NAME):$@ $@ 
	docker tag --force ${NAME}:$@ ${LOCAL}/${NAME}:$@
	docker push ${LOCAL}/${NAME}:$@ 
	docker rmi ${LOCAL}/${NAME}:$@