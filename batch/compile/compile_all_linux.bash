#!/bin/bash

source ./erase_all_linux.bash

date >> output.txt

START_TIME=$(date +%s)

TARGET="${1:-}"
DEBUG_EXTCFG="${2:-}"
MEMORY_EXTCFG="${3:-}"
TRACE_EXTCFG="${4:-}"
FEEDBACK_EXTCFG="${5:-}"
IMAGEBASE="${6:-}"

export TARGET DEBUG_EXTCFG MEMORY_EXTCFG TRACE_EXTCFG FEEDBACK_EXTCFG IMAGEBASE

export SO_PATH="Linux"

echo --------------------------------------------------------------------------
printf "Start process ... \n\n"

source ./defaultenv.bash


if [ "$TARGET" = "INTEL32" ]; then  
  printf "INTEL32 target not valid: Change to INTEL64\n"
  export TARGET="INTEL64"
fi

OLDPATH=$(pwd)
OUTFILE="$OLDPATH/output.txt"
export OUTFILE


printf "GEN Plataform $TARGET, External Config [ Debug $DEBUG_EXTCFG, Memory Control $MEMORY_EXTCFG, Trace $TRACE_EXTCFG, FeedBack $FEEDBACK_EXTCFG, Image Base (docker) $IMAGEBASE]\n"
echo

printf "GEN Plataform $TARGET, External Config [ Debug $DEBUG_EXTCFG, Memory Control $MEMORY_EXTCFG, Trace $TRACE_EXTCFG, FeedBack $FEEDBACK_EXTCFG, Image Base (docker) $IMAGEBASE]\n" >> $OUTFILE
printf "\n" >> $OUTFILE

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
    bash ./internal/compile_linux.bash "$param1" "$param2" 
  else
    echo "Línea con formato inválido (se ignora): $line" >&2
  fi
done < "$FILE"


END_TIME=$(date +%s)
ELAPSED_TIME=$((END_TIME - START_TIME))
HOURS=$((ELAPSED_TIME / 3600))
MINUTES=$(((ELAPSED_TIME % 3600) / 60 ))
SECONDS=$((ELAPSED_TIME % 60))

echo --------------------------------------------------------------------------
printf "End process.\nProcessing time: %02d:%02d:%02d\n" "$HOURS" "$MINUTES" "$SECONDS"
echo --------------------------------------------------------------------------

