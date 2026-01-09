#!/bin/bash

export TARGET="${1:-}"
export IMAGEBASE="${2:-}"
export PATHLISTAPP="${3:-}"

source ./defaultenv.bash

if [ "$PATHLISTAPP" = "" ]; then
 export PATHLISTAPP="$(pwd)/"
fi

FILELISTAPP=$PATHLISTAPP"listapp.txt"

printf "GEN Plataform $TARGET, Image Base $IMAGEBASE, List app $PATHLISTAPP\n"
echo

bash -c "docker compose -f ../../docker/docker-compose-prod.yml down"

set -euo pipefail

while IFS= read -r line || [[ -n "$line" ]]; do
  # saltar líneas vacías o solo espacios
  [[ -z "${line//[[:space:]]/}" ]] && continue

  # Extrae lo que hay entre comillas: "a" "b"
  if [[ "$line" =~ ^[[:space:]]*\"([^\"]*)\"[[:space:]]+\"([^\"]*)\"[[:space:]]*$ ]]; then
    PARAM1="${BASH_REMATCH[1]}"
    PARAM2="${BASH_REMATCH[2]}"
       
    # Llama pasando DOS argumentos separados
    source ./deploy.bash "$TARGET" "$IMAGEBASE" "$PARAM1" "$PARAM2" 
  else
    echo "Línea con formato inválido (se ignora): $line" >&2
  fi
done < "$FILELISTAPP"


bash -c "docker compose -f ../../docker/docker-compose-prod.yml up"
