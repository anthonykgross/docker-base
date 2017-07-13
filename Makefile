NAME=anthonykgross/docker-base

build:
	docker build --file="Dockerfile" --tag="$(NAME):latest" .

debug:
	docker run -it --rm --entrypoint=/bin/bash $(NAME):latest

run:
	echo "Nothing to run. You've to extend this image"