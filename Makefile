.PHONY: build run stop

REPO = fredblgr/
IMAGE= ubuntunovnc-3asem
TAG  = 2019
TAG2 = 2020

build:
	docker build -t $(REPO)$(IMAGE):$(TAG) .

build2020:
	docker build -f Dockerfile2020 -t $(REPO)$(IMAGE):$(TAG2) .

run:
	docker run --rm -d \
		-p 6080:80 \
		-v ${PWD}:/workspace:rw \
		-e USER=student -e PASSWORD=CS3ASL \
		-e RESOLUTION=1680x1050 \
		--name $(IMAGE)-test \
		$(REPO)$(IMAGE):$(TAG)
	sleep 5
	open -a firefox http://localhost:6080

run2020:
	docker run --rm -d \
		-p 6080:80 \
		-v ${PWD}:/workspace:rw \
		-e USER=student -e PASSWORD=CS3ASL \
		-e RESOLUTION=1680x1050 \
		--name $(IMAGE)-test \
		$(REPO)$(IMAGE):$(TAG2)
	sleep 5
	open -a firefox http://localhost:6080

runasroot:
	docker run --rm -d \
		-p 6080:80 \
		-v ${PWD}:/workspace:rw \
		-e RESOLUTION=1680x1050 \
		--name $(IMAGE)-test \
		$(REPO)$(IMAGE):$(TAG)
	sleep 5
	open -a firefox http://localhost:6080

stop:
	docker stop $(IMAGE)-test
