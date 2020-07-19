#!/bin/sh
REPO=fredblgr/
IMAGE=ubuntunovnc-3asem
TAG=2020
URL=http://localhost:6080

docker run --rm -d \
		  -p 6080:80 \
		  -v ${PWD}:/workspace:rw \
		  -e USER=student -e PASSWORD=CS3ASL \
		  -e RESOLUTION=1680x1050 \
		  --name ${IMAGE}-run \
		  ${REPO}${IMAGE}:${TAG}
sleep 5

if command -v open 2>&1 /dev/null
then
  echo "Found 'open' command"
  open ${URL}
elif command -v xdg-open2 2>&1 /dev/null
then
  xdg-open "${URL}"
else
  echo "# Point your browser at ${URL}"
  echo "You may install xdg-utils so that I can do that for you."
fi
