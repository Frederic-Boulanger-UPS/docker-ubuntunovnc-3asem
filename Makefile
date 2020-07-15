.PHONY: build run stop

REPO = fredblgr/ubuntunovnc-3asem
TAG  = 2020

build:
	docker build -t $(REPO):$(TAG) .

run:
	docker run --rm -d \
		-p 6080:80 \
		-v ${PWD}:/workspace:rw \
		-e USER=student -e PASSWORD=CS3ASL \
		-e RESOLUTION=1680x1050 \
		--name ubuntunovnc-3asem-test \
		$(REPO):$(TAG)
	sleep 5
	open -a firefox http://localhost:6080

runasroot:
	docker run --rm -d \
		-p 6080:80 \
		-v ${PWD}:/workspace:rw \
		-e RESOLUTION=1680x1050 \
		--name ubuntunovnc-3asem-test \
		$(REPO):$(TAG)
	sleep 5
	open -a firefox http://localhost:6080

stop:
	docker stop ubuntunovnc-3asem-test
