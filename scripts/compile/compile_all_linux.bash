#!/bin/bash

START_TIME=$(date +%s)

TARGET="${1:-}"
DEBUG_EXTCFG="${2:-}"
MEMORY_EXTCFG="${3:-}"
TRACE_EXTCFG="${4:-}"
FEEDBACK_EXTCFG="${5:-}"
IMAGEBASE="${6:-}"
PATHLISTAPP="${7:-}"

export TARGET DEBUG_EXTCFG MEMORY_EXTCFG TRACE_EXTCFG FEEDBACK_EXTCFG IMAGEBASE PATHLISTAPP

source ./defaultenv.bash

if [ "$PATHLISTAPP" = "" ]; then
 export PATHLISTAPP="$(pwd)/"
fi

FILELISTAPP=$PATHLISTAPP"listapp.txt"
OUTFILE=$PATHLISTAPP"output.txt"

export FILELISTAPP OUTFILE

export SO_PATH="Linux"

bash ./erase_all_linux.bash $PATHLISTAPP

date >> $OUTFILE

echo --------------------------------------------------------------------------
printf "Start process ... \n\n"

if [ "$TARGET" = "INTEL32" ]; then  
  printf "INTEL32 target not valid: Change to INTEL64\n"
  export TARGET="INTEL64"
fi

printf "GEN Plataform $TARGET, Debug $DEBUG_EXTCFG, Memory Control $MEMORY_EXTCFG, Trace $TRACE_EXTCFG, FeedBack $FEEDBACK_EXTCFG, Image Base $IMAGEBASE, List app $PATHLISTAPP\n"
echo

printf "GEN Plataform $TARGET, Debug $DEBUG_EXTCFG, Memory Control $MEMORY_EXTCFG, Trace $TRACE_EXTCFG, FeedBack $FEEDBACK_EXTCFG, Image Base $IMAGEBASE, List app $PATHLISTAPP\n" >> $OUTFILE
printf "\n" >> $OUTFILE

set -euo pipefail

while IFS= read -r line || [[ -n "$line" ]]; do
  # saltar líneas vacías o solo espacios
  [[ -z "${line//[[:space:]]/}" ]] && continue

  # Extrae lo que hay entre comillas: "a" "b"
  if [[ "$line" =~ ^[[:space:]]*\"([^\"]*)\"[[:space:]]+\"([^\"]*)\"[[:space:]]*$ ]]; then
    PARAM1="${BASH_REMATCH[1]}"
    PARAM2="${BASH_REMATCH[2]}"

    # Llama pasando DOS argumentos separados
    bash ./internal/compile_linux.bash "$PARAM1" "$PARAM2" 
  else
    echo "Línea con formato inválido (se ignora): $line" >&2
  fi
done < "$FILELISTAPP"


END_TIME=$(date +%s)
ELAPSED_TIME=$((END_TIME - START_TIME))
HOURS=$((ELAPSED_TIME / 3600))
MINUTES=$(((ELAPSED_TIME % 3600) / 60 ))
SECONDS=$((ELAPSED_TIME % 60))

echo --------------------------------------------------------------------------
printf "End process.\nProcessing time: %02d:%02d:%02d\n" "$HOURS" "$MINUTES" "$SECONDS"
echo --------------------------------------------------------------------------

