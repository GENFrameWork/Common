#!/bin/bash

export TARGET=$1
export DEBUG_EXTCFG=$2
export MEMORY_EXTCFG=$3
export TRACE_EXTCFG=$4
export FEEDBACK_EXTCFG=$5
export IMAGEBASE=$6

#export TARGET_IMG=${TARGET,,}

COMPILE_IMAGE="gen_compiler"
DOCKER_FILE_BUILD=dockerfile_build
GEN_PATH=../../../
BIND_MOUNT_GEN=/mnt/d/Projects/GEN_FrameWork:/GEN_FrameWork

source ./defaultenv.bash

bash -c "docker build --build-arg TARGET=$TARGET --build-arg IMAGEBASE=$IMAGEBASE -t $COMPILE_IMAGE -f $GEN_PATH/Common/batch/docker/$DOCKER_FILE_BUILD $GEN_PATH"                        
bash -c "docker run -it --rm --name gen_compiler_container -e TARGET=$TARGET -e DEBUG_EXTCFG=$DEBUG_EXTCFG -e MEMORY_EXTCFG=$MEMORY_EXTCFG -e TRACE_EXTCFG=$TRACE_EXTCFG -e FEEDBACK_EXTCFG=$FEEDBACK_EXTCFG -e IMAGEBASE=$IMAGEBASE -v $BIND_MOUNT_GEN $COMPILE_IMAGE"
