#!/bin/bash

export TARGET_LOWERCASE=${TARGET,,}


if [[ "$DEBUG_EXTERNAL_CFG" == "DEBUG" || "$DEBUG_EXTERNAL_CFG" == "NONE" ]]; then
  COMPILED_MODE="debug"
fi  

if [ "$DEBUG_EXTERNAL_CFG" == "RELEASE" ]; then
  COMPILED_MODE="release"
fi 


export COMPILED_MODE

bash -c "docker compose -f "$PATHLISTAPP../../Docker/docker-compose-prod.yml" down  $APPNAME"
bash -c "docker compose -f "$PATHLISTAPP../../Docker/docker-compose-prod.yml" build $APPNAME"
bash -c "docker compose -f "$PATHLISTAPP../../Docker/docker-compose-prod.yml" up    $APPNAME"

