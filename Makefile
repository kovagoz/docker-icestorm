TAG ?= latest

.PHONY: build
build:
	docker build -t kovagoz/icestorm:$(TAG) .

.PHONY: push
push:
	docker push kovagoz/icestorm:$(TAG)
