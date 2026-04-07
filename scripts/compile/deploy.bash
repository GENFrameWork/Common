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
indocker=false

# Regex helpers
is_uppercase()      { [[ "$1" =~ ^[A-Z0-9]+$ ]];        }
is_lowercase()      { [[ "$1" =~ ^[a-z0-9_-]+$ ]]; }
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
      
      if [[ "${variable_params_keys[$i]}" == "IMAGEBASE" ]]; then
          export IMAGEBASE=${variable_params_values[$i]}
      fi

    done
fi


source ./defaultenv.bash

SO_PATH="Linux"
FILELISTAPP="${PATHLISTAPP}${LISTAPP}"

export SO_PATH FILELISTAPP 

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
  
  
# Application params
if [ ${#application_params[@]} -gt 0 ]; then  
  export APPLIST_COMPILE="${application_params[*]}"
else 
  export APPLIST_COMPILE="${applications[*]}"
fi

# Variation params
if [[ ${#variation_params[@]} -gt 0 ]]; then

  for v in "${variation_params[@]}"; do
      
    # ------------------------------------
    
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
    
    # ------------------------------------
    
    if [ "$v" == "DEBUG" ]; then
      modes+=("$v")
    fi

    if [ "$v" == "RELEASE" ]; then
      modes+=("$v")
    fi

    # ------------------------------------
          
  done

fi


if [[ ${#platforms[@]} -eq 0 ]]; then

  platforms+=("INTEL64")
 #platforms+=("ARM32")
 #platforms+=("ARM64")
 #platforms+=("RPI32")
 #platforms+=("RPI64")

fi


if [[ ${#modes[@]} -eq 0 ]]; then

  #modes+=("DEBUG")
  modes+=("RELEASE")

fi


echo -------------------------------------------------------------
echo "Modes          : ${modes[*]}"
echo "Plataforms     : ${platforms[*]}" 
echo "Image Base     : Compilation Docker with $IMAGEBASE"  
echo "Applications   : ${APPLIST_COMPILE}"
echo -------------------------------------------------------------
     
for p in "${platforms[@]}"; do  

  export TARGET=$p 

  for m in "${modes[@]}"; do
    
    export DEBUG_EXTERNAL_CFG=${m,,}

    if [ ${#application_params[@]} -gt 0 ]; then  

      for app in "${application_params[@]}"; do
        
        index=0    
        
        for a in "${applications[@]}"; do  
                                                  
          if [[ "$app" == "$a" ]]; then
          
            export APPPATH="${applications_path[$index]}"
            export APPNAME=$a
                                                   
            source ./internal/deploy_app.bash $APPNAME
        
          fi     

          ((index=index+1))  
           
        done  
      
      done    
      
    else  
    
      index=0    
        
      for a in "${applications[@]}"; do  
                                                           
        export APPPATH="${applications_path[$index]}"
        export APPNAME=$a
                                    
        source ./internal/deploy_app.bash $APPNAME
                
        ((index=index+1))  
           
      done   
    
    fi      
   
  done
  
done  
  



    