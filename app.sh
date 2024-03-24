#!/bin/bash

docker_compose="docker-compose -f docker-compose.yml"

if [[ $1 = "start" ]]; then
  echo "Starting Development Environment..."
	$docker_compose up -d
elif [[ $1 = "stop" ]]; then
	echo "Stopping Development Environment..."
	$docker_compose stop
elif [[ $1 = "restart" ]]; then
	echo "Restarting Development Environment..."
  $docker_compose down
  $docker_compose start
elif [[ $1 = "down" ]]; then
	echo "Tearing Down Development Environment..."
	$docker_compose down
elif [[ $1 = "rebuild" ]]; then
	echo "Rebuilding Development Environment..."
	$docker_compose down --remove-orphans
	$docker_compose build --no-cache
elif [[ $1 = "shell" ]]; then
	docker exec -it development-env bash
elif [[ $1 = "logs" ]]; then
	docker logs development-env
elif [[ $1 = "volumes" ]]; then
	echo "Creating Development Environment Volumes..."
	docker volume create dev-env-home
else
	echo "Unkown or missing command..."
fi