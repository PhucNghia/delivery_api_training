#!/bin/bash

own_directory() {
  if [ -d $1 ]
  then
    sudo chown -R $(id -u):$(id -g) $1
    echo "chown directory: $1"
  else
    echo "$1 isn't a directory"
  fi
}

up_project() {
	(sudo docker-compose up -d)
	(cd api && sudo docker-compose up -d)
	(cd front-end && sudo docker-compose up)
}

down_project() {
	(sudo docker-compose down)
	(cd api && sudo docker-compose down)
	(cd front-end && sudo docker-compose down)
}

rspec_api() {
	(cd api && sudo docker-compose run delivery-api bundle exec rspec $@)
}

while test $# -gt 0; do
	case "$1" in
		"own")
			shift
			own_directory $1
			exit 0
			;;
		"up")
			shift
			up_project
			exit 0
			;;
		"down")
			shift
			down_project
			exit 0
			;;
		"rspec")
				shift
				rspec_api $@
				exit 0
			;;
		"byebug")
			shift
			sudo docker attach delivery-api
			;;
	esac
done
