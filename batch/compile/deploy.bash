#!/bin/bash

export TARGET="${1:-}"
export IMAGEBASE="${2:-}"
export APPPATH="${3:-}"
export APPNAME="${4:-}"

export TARGET_IMG=${TARGET,,}

#bash -c "docker compose -f ../../docker/docker-compose-prod.yml down"
bash  -c "docker compose -f ../../docker/docker-compose-prod.yml build $APPNAME"
#bash -c "docker compose -f ../../docker/docker-compose-prod.yml up"

