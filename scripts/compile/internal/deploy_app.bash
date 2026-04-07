#!/bin/bash

export TARGET_LOWERCASE=${TARGET,,}

bash -c "docker compose -f ../../docker/docker-compose-prod.yml down  $APPNAME"
bash -c "docker compose -f ../../docker/docker-compose-prod.yml build $APPNAME"
bash -c "docker compose -f ../../docker/docker-compose-prod.yml up    $APPNAME"

