#!/bin/bash

DIR="$1/Platforms/$SO_PATH/$PLATFORM_PATH"
OLDPATH=$(pwd)

if [ ! -d "$1/Platforms/$SO_PATH" ]; then
  mkdir $1/Platforms/$SO_PATH;
fi
 
if [ -d "$DIR" ]; then 
  rm $DIR -R; 
fi

if [ ! -d "$DIR" ]; then
  mkdir $DIR;
fi

cd $DIR

printf "\n\n[%s]\n\n" $2 >> "$OUTFILE" 2>&1

printf "[#CMake#]\n"  >> "$OUTFILE" 2>&1
printf "Generate CMake      %-16s ... " $2 
cmake -G "Ninja" -DTARGET=$TARGET -DDEBUG_EXTCFG=$DEBUG_EXTCFG -DMEMORY_EXTCFG=$MEMORY_EXTCFG -DTRACE_EXTCFG=$TRACE_EXTCFG -DFEEDBACK_EXTCFG=$FEEDBACK_EXTCFG ../..  >> "$OUTFILE" 2>&1
if [ $? -eq 0 ]; then
    printf "[Ok]\n" 
else
    printf "[Error!]\n" 
fi


printf "[#Compilate#]\n"  >> "$OUTFILE" 2>&1
printf "Compilate project   %-16s ... " $2
ninja -j8  >> "$OUTFILE" 2>&1
if [ $? -eq 0 ]; then    
    printf "[Ok]\n" 
else
    printf "[Error!]\n" 
fi


if [[ "$TARGET" == "INTEL32" || "$TARGET" == "INTEL64" ]]; then
  if [ -e "$2tests" ]; then
    printf "[#Tests#]\n"  >> "$OUTFILE" 2>&1
    printf "Test project        %-16s ... " $2
    ./$2tests  >> "$OUTFILE" 2>&1
    if [ $? -eq 0 ]; then    
        printf "[Ok]\n" 
    else
        printf "[Error!]\n" 
    fi
  fi  
fi

cd $OLDPATH

printf "\n" 