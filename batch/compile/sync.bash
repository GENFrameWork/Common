#!/bin/bash

SRC_WIN="/mnt/e/Projects/GEN_FrameWork"             
MIRROR_BASE="/home/Projects/GEN_FrameWork" 
SYNC_TRANSFERRED="0"            

HERE=$(pwd)

if [[ "$HERE" == /home/* ]]; then
 
  echo -------------------------------------------------------------
  printf "Sync Sources ... \n"
  
  source ./sync_from_windows.sh "$SRC_WIN" "$MIRROR_BASE"
  chmod 755 $MIRROR_BASE -R   
  
  printf "Modified Files: %s\n" "$SYNC_TRANSFERRED" 
  
  echo ------------------------------------------------------------- 
  
fi



