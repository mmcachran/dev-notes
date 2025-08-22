#!/bin/bash

readonly DOCKER_IMAGE_NAME="kraken-bash-image"

dclean () {
	docker stop $(docker ps -a -q)
	docker rm $(docker ps -a -q)
    docker system prune -a -f
}

run_test() {
    # https://stackoverflow.com/questions/32163955/how-to-run-shell-script-on-host-from-docker-container
    # docker run --rm -v $(pwd)/run.sh:/run.sh ubuntu bash /run.sh
    # docker run --rm -v /usr/bin:/usr/bin --privileged -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd)/build/main.sh:/main.sh ubuntu bash /main.sh
    docker run --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd)/dist/main.sh:/main.sh ubuntu bash /main.sh
}

dclean
run_test
# docker build -t "$DOCKER_IMAGE_NAME" --no-cache .
# docker run --privileged --pid=host -it "$DOCKER_IMAGE_NAME"


