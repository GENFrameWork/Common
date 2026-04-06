#!/bin/bash


printf " ---- %s %s \n" $APPPATH $APPNAME 

export TARGET_LOWERCASE=${TARGET,,}

#bash -c "docker compose -f ../../docker/docker-compose-prod.yml down"
bash  -c "docker compose -f ../../docker/docker-compose-prod.yml build $APPNAME"
#bash -c "docker compose -f ../../docker/docker-compose-prod.yml up"

