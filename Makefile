RUNTIME   ?= 3.11
IMAGE     ?= produits-api
HOST_PORT ?= 5000
CONTAINER  = $(IMAGE)-$(RUNTIME)

.PHONY: build run smoke clean

build:
	docker build --build-arg RUNTIME=$(RUNTIME) -t $(IMAGE):$(RUNTIME) .

run:
	-docker rm -f $(CONTAINER)
	docker run -d --name $(CONTAINER) -p $(HOST_PORT):5000 $(IMAGE):$(RUNTIME)

smoke:
	bash scripts/smoke.sh http://localhost:$(HOST_PORT)

clean:
	-docker rm -f $(CONTAINER)
	-docker rmi $(IMAGE):$(RUNTIME)
	