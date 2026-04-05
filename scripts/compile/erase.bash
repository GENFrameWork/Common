#!/bin/bash


# ---------------------------------------
# compiler.bash - Parameter classifier
# ---------------------------------------
# Types of parameters:
# 1. Variation parameter: UPPERCASE (A-Z0-9)
# 2. Application parameter: lowercase (a-z)
# 3. Variable parameter: UPPERCASE=VALUE
# ---------------------------------------


variation_params=()
application_params=()

modes=()
platforms=()
applications=()
applications_path=()

allplatforms=false
allmodes=false

# Regex helpers
is_uppercase()      { [[ "$1" =~ ^[A-Z0-9]+$ ]];        }
is_lowercase()      { [[ "$1" =~ ^[a-z]+$ ]];           }
is_variable_param() { [[ "$1" =~ ^([A-Z0-9]+)=(.*)$ ]]; }

# ---------------------------------------
# Parameter classification loop
# ---------------------------------------
for param in "$@"; do
    if is_variable_param "$param"; then
        key="${param%%=*}"
        val="${param#*=}"
        variable_params_keys+=("$key")
        variable_params_values+=("$val")

    elif is_uppercase "$param"; then
        variation_params+=("$param")

    elif is_lowercase "$param"; then
        application_params+=("$param")

    else
        echo "[Unknown parameter] => $param"
        exit
    fi
done



# Variable params
if [[ ${#variable_params_keys[@]} -gt 0 ]]; then

    for i in "${!variable_params_keys[@]}"; do

      if [[ "${variable_params_keys[$i]}" == "PATHLISTAPP" ]]; then
          export PATHLISTAPP=${variable_params_values[$i]}
      fi

    done
fi


source ./defaultenv.bash

SO_PATH="Linux"
FILELISTAPP="${LISTAPP}"
OUTFILE="${PATHLISTAPP}/../../../output.txt"

export SO_PATH FILELISTAPP OUTFILE




# Application params
if [ ${#application_params[@]} -gt 0 ]; then
 
  applications="${applications_params[*]}"
  export APPLIST_COMPILE="${applications[*]}"
   
else

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
  
  export APPLIST_COMPILE="${applications[*]}"

fi



# Variation params
if [[ ${#variation_params[@]} -gt 0 ]]; then

  for v in "${variation_params[@]}"; do
    
    if [ "$v" == "DEBUG" ]; then
      modes+=("$v")
    fi

    if [ "$v" == "RELEASE" ]; then
      modes+=("$v")
    fi
    
    if [ "$v" == "INTEL64" ]; then
      platforms+=("$v")
    fi

    if [ "$v" == "ARM32" ]; then
      platforms+=("$v")
    fi
    
    if [ "$v" == "ARM64" ]; then
      platforms+=("$v")
    fi
    
    if [ "$v" == "RPI32" ]; then
      platforms+=("$v")
    fi
    
    if [ "$v" == "RPI64" ]; then
      platforms+=("$v")
    fi

  done

fi


if [[ ${#platforms[@]} -eq 0 ]]; then

  platforms+=("INTEL64")
  platforms+=("ARM32")
  platforms+=("ARM64")
  platforms+=("RPI32")
  platforms+=("RPI64")
  
  allplatforms=true
  
fi


if [[ ${#modes[@]} -eq 0 ]]; then

  modes+=("DEBUG")
  modes+=("RELEASE")
  
  allmodes=true

fi


echo -------------------------------------------------------------
echo "Modes        : ${modes[*]}"
echo "Plataforms   : ${platforms[*]}"
echo "Applications : ${applications[*]}"
echo


if [ -f "$OUTFILE" ]; then
  printf "Removing output.txt\n"
  rm -f "$OUTFILE"
fi


indice=0

for a in "${applications[@]}"; do  
  
  printf "Erase build : %-20s [ " $a    
  
  directory="${applications_path[$indice]}/Platforms"     
 
  if [ -d "$directory/.vs" ]; then
    printf ".vs "
    sudo rm -rf "$directory/.vs"
  fi

  if [ -d "$directory/.vscode" ]; then
    printf ".vscode "
    sudo rm -rf "$directory/.vscode"
  fi  
  
  directory="$directory/$SO_PATH" 
    
  if [ "$allplatforms" = true ]; then  
     
   if [ -d "$directory" ]; then                
      printf "%s " $SO_PATH
      sudo rm -rf "$directory"               
   fi      
    
  else
  
    for p in "${platforms[@]}"; do 
    
      p=${p,,}
                        
      if [ "$allmodes" = true ]; then  
                     
        if [ -d "$directory/$p" ]; then                
          printf "%s " $p 
          sudo rm -rf "$directory/$p"               
        fi      
        
      else
        
        for m in "${modes[@]}"; do        
            
          m=${m,,}
                
          directory="$directory/$p/$m"

          if [ -d "$directory" ]; then
            printf "%s/%s " $p $m
            sudo rm -rf "$directory"               
          fi      

        done
       
      fi 
        
    done
    
  fi
                
  printf "] \n" 
  
  indice=$((indice + 1))
  
done   

echo -------------------------------------------------------------


# Optional pause
# echo "Press any key to continue..."
# read -n 1 -s