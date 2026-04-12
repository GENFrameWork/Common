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


print_app_header() 
{
  local STAGE="$1"
  local APP="$2"
  local TARGET="$3"
  local DEBUG_EXTERNAL_CFG="$4"
  local OUTFILE="$5"

  printf "\n\n[#STAGE %s,%s,%s,%s]\n" "$STAGE" "$APP" "$TARGET" "$DEBUG_EXTERNAL_CFG"  >> "$OUTFILE" 2>&1
  printf "_______________________________________________________________________________________________________________________________________________________________________________\n" >> "$OUTFILE" 2>&1   
}
 

if [ "$STAGE" == "CMAKE" ]; then
    
  print_app_header "CMAKE" "$3" "$TARGET" "$DEBUG_EXTERNAL_CFG" "$OUTFILE"  
  printf "%-10s %-10s Generate CMake           %-22s ... " $TARGET $DEBUG_EXTERNAL_CFG $3  
  
  cmake -G "Ninja" -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DTARGET=$TARGET -DUSE_CLANG_EXTCFG=$USE_CLANG_EXTCFG -DCOVERAGE_CREATEINFO_EXTERNAL_CFG=$COVERAGE_CREATEINFO_EXTERNAL_CFG -DDEBUG_EXTCFG=$DEBUG_EXTCFG -DMEMORY_EXTCFG=$MEMORY_EXTCFG -DTRACE_EXTCFG=$TRACE_EXTCFG -DFEEDBACK_EXTCFG=$FEEDBACK_EXTCFG -DPATHLISTAPP=$PATHLISTAPP ../../../..  >> "$OUTFILE" 2>&1
  if [ $? -eq 0 ]; then
      printf "[Ok]\n" 
  else
      printf "[Error!]\n" 
  fi 
fi



if [ "$STAGE" == "COMPILE" ]; then

  print_app_header "COMPILE" "$3" "$TARGET" "$DEBUG_EXTERNAL_CFG" "$OUTFILE"
  printf "%-10s %-10s Compilate project        %-22s ... " $TARGET $DEBUG_EXTERNAL_CFG $3  
  
  ninja  >> "$OUTFILE" 2>&1 
  if [ $? -eq 0 ]; then    
    printf "[Ok]\n" 
   else
    printf "[Error!]\n" 
  fi
   
fi



if [ "$STAGE" == "TEST" ]; then

  if [[ "$3" == *_unittests && "$TARGET" == "INTEL64" ]]; then
  
    print_app_header "TEST" "$3" "$TARGET" "$DEBUG_EXTERNAL_CFG" "$OUTFILE"   
    printf "%-10s %-10s Test project             %-22s ... " $TARGET $DEBUG_EXTERNAL_CFG $3   
    
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



