#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Uso: $0 directorio"
  exit 1
fi

directory="$1"

echo "Remove directory $directory"
if [ -d "$directory/Platforms/.vs" ]; then
  rm -rf "$directory/Platforms/.vs"
fi

if [ -d "$directory/Platforms/Windows" ]; then
  rm -rf "$directory/Platforms/Windows"
fi

if [ -d "$directory/Platforms/out" ]; then
  rm -rf "$directory/Platforms/out"
fi

if [ -d "$directory/Platforms/Linux" ]; then
  rm -rf "$directory/Platforms/Linux"
fi

if [ -d "$directory/Platforms/Android" ]; then
  rm -rf "$directory/Platforms/Android"
fi

exit 0

