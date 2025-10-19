#!/bin/sh
DIR=$1$2
OLDPATH=$(pwd)

if [ ! -d "$1" ]; then
  mkdir $1;
fi
 
if [ -d "$DIR" ]; then 
  rm $DIR -R; 
fi

if [ ! -d "$DIR" ]; then
  mkdir $DIR;
fi


cd $DIR
 
printf "Generate CMake    %-16s ... " $3 
cmake -G "Ninja" -DTARGET=INTEL ../..  >> "$OUTFILE" 2>&1
if [ $? -eq 0 ]; then
    printf "[Ok]\n" 
else
    printf "[Error!]\n" 
fi

printf "Compilate project %-16s ... " $3
ninja  >> "$OUTFILE" 2>&1
if [ $? -eq 0 ]; then    
    printf "[Ok]\n" 
else
    printf "[Error!]\n" 
fi

if [ -e "$3tests" ]; then
printf "Test project      %-16s ... " $3
  ./$3tests  >> "$OUTFILE" 2>&1
  if [ $? -eq 0 ]; then    
      printf "[Ok]\n" 
  else
      printf "[Error!]\n" 
  fi
fi

cd $OLDPATH

printf "\n" 