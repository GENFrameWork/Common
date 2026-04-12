#!/bin/bash

applications=()
applications_path=()
index=0

set -euo pipefail

while IFS= read -r line || [[ -n "$line" ]]; do
  # saltar líneas vacías o solo espacios
  [[ -z "${line//[[:space:]]/}" ]] && continue

  # Extrae lo que hay entre comillas: "a" "b"
  if [[ "$line" =~ ^[[:space:]]*\"([^\"]*)\"[[:space:]]+\"([^\"]*)\"[[:space:]]*$ ]]; then
    param1="${BASH_REMATCH[1]}"
    param2="${BASH_REMATCH[2]}"
        
    applications_path+=("$param1")
    applications+=("$param2")
    
  else
    echo "Línea con formato inválido (se ignora): $line" >&2
  fi
  
done < "$FILELISTAPP"

set +euo pipefail

export TARGET_LOWERCASE=${TARGET,,}
 
for app in "$@"; do
    
  index=0    
    
  for a in "${applications[@]}"; do  
            
    if [[ "$app" == "$a" ]]; then
      
      source ./internal/compile_linux.bash "${applications_path[$index]}/CMake/Build/${SO_PATH}" $TARGET_LOWERCASE $app  
    
    fi     

    ((index=index+1))  
       
  done  
  
done  



