@echo off

set docker_compose=docker-compose -f docker-compose.yml

if "%1"=="start" (
  echo Starting Development Environment...
  %docker_compose% up -d
) elseif "%1"=="stop" (
  echo Stopping Development Environment...
  %docker_compose% stop
) elseif "%1"=="restart" (
  echo Restarting Development Environment...
  %docker_compose% down
  %docker_compose% start
) elseif "%1"=="down" (
  echo Tearing Down Development Environment...
  %docker_compose% down
) elseif "%1"=="rebuild" (
  echo Rebuilding Development Environment...
  %docker_compose% down --remove-orphans
  %docker_compose% build --no-cache
) elseif "%1"=="shell" (
  docker exec -it development-env bash
) elseif "%1"=="logs" (
  docker logs development-env
) elseif "%1"=="volumes" (
  echo Creating Development Environment Volumes...
  docker volume create dev-env-home
) else (
  echo Unknown or missing command...
)
