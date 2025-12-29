#!/bin/bash

set -euo pipefail

FILE="listapp.txt"

while IFS= read -r line || [[ -n "$line" ]]; do
  # saltar líneas vacías o solo espacios
  [[ -z "${line//[[:space:]]/}" ]] && continue

  # Extrae lo que hay entre comillas: "a" "b"
  if [[ "$line" =~ ^[[:space:]]*\"([^\"]*)\"[[:space:]]+\"([^\"]*)\"[[:space:]]*$ ]]; then
    param1="${BASH_REMATCH[1]}"
    param2="${BASH_REMATCH[2]}"

    # Llama pasando DOS argumentos separados
    bash internal/erase_artifacts.bash "$param1"
  else
    echo "Línea con formato inválido (se ignora): $line" >&2
  fi
done < "$FILE"


if [ -f "Output.txt" ]; then
  rm Output.txt
fi

#echo Press any key to continue ...
#read KEY


