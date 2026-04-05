#!/bin/bash

# $1 directory         ../../../Examples/Base/NotAppExample/Plaforms/Linux
# $2 /$TARGET_LOWERCASE
# $3 [application]

DIR="$1/$2"
OLDPATH=$(pwd)
COMPILED_MODE=""
copylib=0


if [[ "$DEBUG_EXTERNAL_CFG" == "DEBUG" || "$DEBUG_EXTERNAL_CFG" == "NONE" ]]; then
  COMPILED_MODE="debug"
fi  


if [ "$DEBUG_EXTERNAL_CFG" == "RELEASE" ]; then
  COMPILED_MODE="release"
fi  


DIR="$DIR/$COMPILED_MODE"
  
if [ "$STAGE" == "CMAKE" ]; then  
  if [ -d "$DIR" ]; then  
    rm $DIR -R;   
  fi
fi


if [ ! -d "$DIR" ]; then
  mkdir -p  $DIR;
fi

cd $DIR

printf "\n\n[#APP_NAME %-10s %-10s %s#]\n" $TARGET $DEBUG_EXTERNAL_CFG $3  >> "$OUTFILE" 2>&1 
printf " _____________________________________________________________________________________________________________________________________________________________________________________\n\n"  $3  >> "$OUTFILE" 2>&1 
 


if [ "$STAGE" == "CMAKE" ]; then
    
  printf "%-10s %-10s Generate CMake           %-22s ... " $TARGET $DEBUG_EXTERNAL_CFG $3 
  printf "[#CMake %s#]\n" $3  >> "$OUTFILE" 2>&1   
  cmake -G "Ninja" -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DTARGET=$TARGET -DUSE_CLANG_EXTCFG=$USE_CLANG_EXTCFG -DCOVERAGE_CREATEINFO_EXTERNAL_CFG=$COVERAGE_CREATEINFO_EXTERNAL_CFG -DDEBUG_EXTCFG=$DEBUG_EXTCFG -DMEMORY_EXTCFG=$MEMORY_EXTCFG -DTRACE_EXTCFG=$TRACE_EXTCFG -DFEEDBACK_EXTCFG=$FEEDBACK_EXTCFG ../../..  >> "$OUTFILE" 2>&1
  if [ $? -eq 0 ]; then
      printf "[Ok]\n" 
  else
      printf "[Error!]\n" 
  fi 
fi



if [ "$STAGE" == "COMPILE" ]; then

  printf "%-10s %-10s Compilate project        %-22s ... " $TARGET $DEBUG_EXTERNAL_CFG $3
  printf "[#Compiled %s#]\n" $3  >> "$OUTFILE" 2>&1 
  ninja  >> "$OUTFILE" 2>&1 
  if [ $? -eq 0 ]; then    
    printf "[Ok]\n" 
   else
    printf "[Error!]\n" 
  fi
   
fi



if [ "$STAGE" == "TEST" ]; then

  if [[ "$3" == *_unittests && "$TARGET" == "INTEL64" ]]; then
   
    printf "%-10s %-10s Test project             %-22s ... " $TARGET $DEBUG_EXTERNAL_CFG $3
    printf "[#Tests %s#]\n" $3  >> "$OUTFILE" 2>&1   
      
    ./$3  >> "$OUTFILE" 2>&1 
    if [ $? -eq 0 ]; then    
        printf "[Ok]\n" 
    else
        printf "[Error!]\n" 
    fi
    
  fi  
  
fi



printf "\n\n" >> "$OUTFILE" 2>&1 

cd $OLDPATH



