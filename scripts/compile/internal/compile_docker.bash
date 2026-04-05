#!/bin/bash

source ./defaultenv.bash

export TARGET_LOWERCASE=${TARGET,,}

IMAGE_COMPILE_NAME="gen_compiler_image_$TARGET_LOWERCASE"
CONTAINER_COMPILE_NAME="gen_compiler_container_$TARGET_LOWERCASE"
DOCKER_FILE_BUILD=dockerfile_build
GEN_PATH=../../..
BIND_MOUNT_GEN=../../$GEN_PATH/Projects:/Projects
BIND_MOUNT_CCACHE=/root/.cache/:/root/.cache/

if docker build \
    --build-arg TARGET="$TARGET" \
    --build-arg IMAGEBASE="$IMAGEBASE" \
    --build-arg SO_PATH="$SO_PATH" \
    --build-arg DOCKERDOMAIN="$DOCKERDOMAIN" \
    -t "$IMAGE_COMPILE_NAME" \
    -f "$GEN_PATH/Common/docker/$DOCKER_FILE_BUILD" \
    "$GEN_PATH"
then
    echo "Build Ok!"

    if docker run -it --rm \
        --name "$CONTAINER_COMPILE_NAME" \
        -e IN_CONTAINER=1 \
        -e TARGET="$TARGET" \
        -e DEBUG_EXTERNAL_CFG="$DEBUG_EXTERNAL_CFG" \
        -e USE_CLANG_EXTCFG="$USE_CLANG_EXTCFG" \
        -e MEMORY_EXTCFG="$MEMORY_EXTCFG" \
        -e TRACE_EXTCFG="$TRACE_EXTCFG" \
        -e FEEDBACK_EXTCFG="$FEEDBACK_EXTCFG" \
        -e COVERAGE_CREATEINFO_EXTERNAL_CFG="$COVERAGE_CREATEINFO_EXTERNAL_CFG" \
        -e IMAGEBASE="$IMAGEBASE" \
        -e PATHLISTAPP="$PATHLISTAPP" \
        -e LISTAPP="$LISTAPP" \
        -e APPLIST_COMPILE="$APPLIST_COMPILE" \
        -e SO_PATH="$SO_PATH" \
        -e DOCKERDOMAIN="$DOCKERDOMAIN" \
        --tmpfs /build:rw,noexec,nosuid,size=16g \
        -v "$BIND_MOUNT_GEN" \
        -v "$BIND_MOUNT_CCACHE" \
        "$IMAGE_COMPILE_NAME" \
        "$@"
    then
      echo "Run Ok!"
    else
      rc=$?
      echo "Error Run. Code: $rc"
      exit $rc
    fi
else
  rc=$?
  echo "Error Build. Code: $rc"
  exit $rc
fi