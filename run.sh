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
	while test $# -gt 0; do
		case $1 in
			"-d")
				_D=$1
				shift;
			;;
			*)
				if test -d $1; then
					DIR=$1
					shift
				fi
			;;
		esac
	done
	echo "Excute command dir: $DIR, flag: $_D"
	if test $# -eq 0; then
		(sudo docker-compose up -d)
		(cd api && sudo docker-compose up -d)
		(cd front-end && sudo docker-compose up)
	else
		(cd $DIR && sudo docker-compose up $_D)
	fi
	exit 0;
}

down_project() {
	echo "Excute command dir: $1"
	if test $# -eq 0; then
		(cd front-end && sudo docker-compose down)
		(cd api && sudo docker-compose down)
		(sudo docker-compose down)
	else
		(cd $1 && sudo docker-compose down)
	fi
	exit 0;
}

rspec_api() {
	(cd api && sudo docker-compose run delivery-api bundle exec rspec $@)
}

case "$1" in
	"own")
		shift
		own_directory $1
		exit 0
		;;
	"up")
		shift
		up_project $@
		exit 0
		;;
	"down")
		shift
		down_project $@
		exit 0
		;;
	"rspec")
			shift
			rspec_api $@
			exit 0
		;;
	"test-script")
		(cd front-end && sudo docker-compose run delivery-front-end npm run test)
	;;
	"byebug")
		shift
		sudo docker attach delivery-api
		;;
esac
