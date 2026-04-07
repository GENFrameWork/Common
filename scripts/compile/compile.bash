#!/bin/bash


# ---------------------------------------
# compiler.bash - Parameter classifier
# ---------------------------------------
# Types of parameters:
# 1. Variation parameter: UPPERCASE (A-Z0-9)
# 2. Application parameter: lowercase (a-z)
# 3. Variable parameter: UPPERCASE=VALUE
# ---------------------------------------

START_TIME=$(date +%s)

variation_params=()
application_params=()

stages=()
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
OUTFILE="../../../outfile.txt"

export SO_PATH FILELISTAPP OUTFILE


# Application params
if [ ${#application_params[@]} -gt 0 ]; then
 
  applications="${application_params[*]}"
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
  
  set +euo pipefail
  
  export APPLIST_COMPILE="${applications[*]}"

fi


# Variation params
if [[ ${#variation_params[@]} -gt 0 ]]; then

  for v in "${variation_params[@]}"; do
    
    # ------------------------------------
             
    if [[ "$v" == "CMAKE" ]]; then
      stages+=("$v")      
    fi

    if [[ "$v" == "COMPILE" ]]; then
      stages+=("$v")
    fi
    
    if [[ "$v" == "TEST" ]]; then
      stages+=("$v")
    fi
   
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
    
    if [[ "$v" == "CLANG" ]]; then
      export USE_CLANG_EXTCFG=$v
    fi

    if [[ "$v" == "NOTCLANG" ]]; then    
      export USE_CLANG_EXTCFG=$v             
    fi
    
    # ------------------------------------
    
    if [[ "$v" == "MEMCTRL" ]]; then
      export MEMORY_EXTCFG=$v
    fi

    if [[ "$v" == "NOTMEMCTRL" ]]; then
      export MEMORY_EXTCFG=$v
    fi
    
    # ------------------------------------
    
    if [[ "$v" == "TRACE" ]]; then
      export TRACE_EXTCFG=$v
    fi

    if [[ "$v" == "TRACENOTINTER" ]]; then
      export TRACE_EXTCFG=$v
    fi
    
    if [[ "$v" == "NOTTRACE" ]]; then
      export TRACE_EXTCFG=$v
    fi
    
    # ------------------------------------
    
    if [[ "$v" == "FEEDBACK" ]]; then
      export FEEDBACK_EXTCFG=$v
    fi

    if [[ "$v" == "NOTFEEDBACK" ]]; then
      export FEEDBACK_EXTCFG=$v
    fi
    
    # ------------------------------------
    
    if [[ "$v" == "COVER" ]]; then
      export COVERAGE_CREATEINFO_EXTERNAL_CFG=$v
    fi

    if [[ "$v" == "NOTCOVER" ]]; then
      export COVERAGE_CREATEINFO_EXTERNAL_CFG=$v
    fi
      
    # ------------------------------------
    
    if [[ "$v" == "DOCKER" ]]; then
      indocker=true
    fi
   
    
  done

fi


if [[ ${#stages[@]} -eq 0 ]]; then

  stages+=("CMAKE")
  stages+=("COMPILE")
  stages+=("TEST")
    
fi


if [[ ${#platforms[@]} -eq 0 ]]; then

  platforms+=("INTEL64")
 #platforms+=("ARM32")
  platforms+=("ARM64")
 #platforms+=("RPI32")
  platforms+=("RPI64")
  
  allplatforms=true
  
fi


if [[ ${#modes[@]} -eq 0 ]]; then

  modes+=("DEBUG")
  modes+=("RELEASE")
  
  allmodes=true

fi

if [[ "${IN_CONTAINER:-0}" == "1" ]]; then
  indocker=false  
fi

if [ -z "$SCRIPTHEADER" ]; then
  export SCRIPTHEADER=false
fi


if [[ "$SCRIPTHEADER" = false ]]; then
  
  if [ -f "$OUTFILE" ]; then
    printf "\nRemoving outfile ...\n\n"
    rm -f $OUTFILE
  fi 
  
  echo -------------------------------------------------------------
  echo "Start process ..."   
  date
  echo "Stages         : ${stages[*]}"
  echo "Modes          : ${modes[*]}"
  echo "Plataforms     : ${platforms[*]}" 
  echo "Applications   : ${applications[*]}"
  
  echo " " > "$OUTFILE" 2>&1   
  echo -------------------------------------------------------------      >> "$OUTFILE" 2>&1   
  echo "Start process ..."                                                >> "$OUTFILE" 2>&1   
  date                                                                    >> "$OUTFILE" 2>&1     
  echo "Stages         : ${stages[*]}"                                    >> "$OUTFILE" 2>&1   
  echo "Modes          : ${modes[*]}"                                     >> "$OUTFILE" 2>&1   
  echo "Plataforms     : ${platforms[*]}"                                 >> "$OUTFILE" 2>&1   
  echo "Applications   : ${applications[*]}"                              >> "$OUTFILE" 2>&1 

fi 


SCRIPTHEADER=true
export SCRIPTHEADER

 
if [ "$indocker" = false ]; then  

  if [[ "${IN_CONTAINER:-0}" == "0" ]]; then    
    
    echo -------------------------------------------------------------          
    echo -------------------------------------------------------------      >> "$OUTFILE" 2>&1   
    
  fi  


  for s in "${stages[@]}"; do
     
    export STAGE=$s 
    
    printf "\n[%s]\n" $s
    
    for p in "${platforms[@]}"; do  
    
      export TARGET=$p
    
      for m in "${modes[@]}"; do
              
        export DEBUG_EXTERNAL_CFG=$m                      
        source ./internal/compile_secuence.bash $APPLIST_COMPILE       
        
      done
      
    done  
    
  done
  
  if [[ "${IN_CONTAINER:-0}" == "0" ]]; then  
    SCRIPTHEADER=false
    export SCRIPTHEADER
  fi
 
else 
    
  PATHLISTAPP="${DOCKERDOMAIN}"
  FILELISTAPP="${PATHLISTAPP}${LISTAPP}"
  OUTFILE="../../../outfile.txt"
  export PATHLISTAPP FILELISTAPP OUTFILE
  
  echo "Image Base     : Compilation Docker with $IMAGEBASE"   
  echo "Image Base     : Compilation Docker with $IMAGEBASE"              >> "$OUTFILE" 2>&1                 
  
  echo -------------------------------------------------------------          
  echo -------------------------------------------------------------      >> "$OUTFILE" 2>&1   
  
  
  ARGS=("$@")
  ARGS_NEW=()
  ARGS_END=()

  for arg in "${ARGS[@]}"; do
  
    if [[ "$arg" != "DOCKER" ]]; then    
      if [[ "$arg" != "INTEL64" ]]; then    
        if [[ "$arg" != "ARM32" ]]; then    
          if [[ "$arg" != "ARM64" ]]; then    
            if [[ "$arg" != "RPI32" ]]; then    
              if [[ "$arg" != "RPI64" ]]; then    
                  ARGS_NEW+=("$arg")
              fi
            fi
          fi
        fi 
      fi  
    fi
    
  done

  for p in "${platforms[@]}"; do  
         
    export TARGET=$p
         
    ARGS_END=("${ARGS_NEW[@]}")
    ARGS_END+=("$p")
    
    source ./internal/compile_docker.bash "${ARGS_END[@]}" 
    
  done 
  
  PATHLISTAPP="$(pwd)/"  
  OUTFILE="../../../outfile.txt"
  export PATHLISTAPP FILELISTAPP OUTFILE
  
  SCRIPTHEADER=false
  export SCRIPTHEADER

fi  

if [[ "$SCRIPTHEADER" = false ]]; then

  END_TIME=$(date +%s)
  ELAPSED_TIME=$((END_TIME - START_TIME))
  HOURS=$((ELAPSED_TIME / 3600))
  MINUTES=$(((ELAPSED_TIME % 3600) / 60 ))
  SECONDS=$((ELAPSED_TIME % 60))

  echo " "
  echo -------------------------------------------------------------
  printf "End process.\nProcessing time: %02d:%02d:%02d\n" "$HOURS" "$MINUTES" "$SECONDS"
  echo -------------------------------------------------------------

  echo " "                                                                                  >> "$OUTFILE" 2>&1   
  echo -------------------------------------------------------------                        >> "$OUTFILE" 2>&1   
  printf "End process.\nProcessing time: %02d:%02d:%02d\n" "$HOURS" "$MINUTES" "$SECONDS"   >> "$OUTFILE" 2>&1   
  echo -------------------------------------------------------------                        >> "$OUTFILE" 2>&1   
  
fi  