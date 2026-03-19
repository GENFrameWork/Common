cmake_minimum_required(VERSION 3.16)

function(gen_android_add_apk_target)
  set(options)
  set(oneValueArgs
    TARGET_NAME
    PROJECT_NAME
    TARGET_SDK
    MIN_SDK
    SHARED_LIBRARY
    OUTPUT_DIR
    SOURCE_ASSETS_DIR
    GENERATED_MANIFEST
    JAVA_HOME
    FRAMEWORK_ROOT
    NDK_ROOT
    SDK_ROOT
    APP_ID
    APP_LABEL
    ABI
  )
  cmake_parse_arguments(GENAPK "${options}" "${oneValueArgs}" "" ${ARGN})

  if(NOT GENAPK_TARGET_NAME)
    message(FATAL_ERROR "gen_android_add_apk_target: falta TARGET_NAME")
  endif()
  if(NOT TARGET "${GENAPK_TARGET_NAME}")
    message(FATAL_ERROR "gen_android_add_apk_target: el target no existe: ${GENAPK_TARGET_NAME}")
  endif()

  if(NOT GENAPK_PROJECT_NAME)
    set(GENAPK_PROJECT_NAME "${GENAPK_TARGET_NAME}")
  endif()

  if(NOT GENAPK_TARGET_SDK)
    if(DEFINED ANDROID_PLATFORM AND NOT "${ANDROID_PLATFORM}" STREQUAL "")
      string(REGEX REPLACE "^android-" "" GENAPK_TARGET_SDK "${ANDROID_PLATFORM}")
    else()
      set(GENAPK_TARGET_SDK "24")
    endif()
  endif()

  if(NOT GENAPK_MIN_SDK)
    set(GENAPK_MIN_SDK "${GENAPK_TARGET_SDK}")
  endif()

  if(NOT GENAPK_OUTPUT_DIR)
    set(GENAPK_OUTPUT_DIR "${CMAKE_BINARY_DIR}")
  endif()

  if(NOT GENAPK_GENERATED_MANIFEST)
    set(GENAPK_GENERATED_MANIFEST "${GENAPK_OUTPUT_DIR}/android_package/AndroidManifest.xml")
  endif()

  if(NOT GENAPK_FRAMEWORK_ROOT)
    get_filename_component(_gen_common_dir "${CMAKE_CURRENT_LIST_DIR}" DIRECTORY)
    get_filename_component(GENAPK_FRAMEWORK_ROOT "${_gen_common_dir}" DIRECTORY)
  endif()

  file(TO_CMAKE_PATH "${GENAPK_FRAMEWORK_ROOT}" GENAPK_FRAMEWORK_ROOT)
  file(TO_CMAKE_PATH "${GENAPK_OUTPUT_DIR}" GENAPK_OUTPUT_DIR)

  if(NOT GENAPK_SOURCE_ASSETS_DIR)
    if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/../assets")
      set(GENAPK_SOURCE_ASSETS_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../assets")
    elseif(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/assets")
      set(GENAPK_SOURCE_ASSETS_DIR "${CMAKE_CURRENT_SOURCE_DIR}/assets")
    else()
      set(GENAPK_SOURCE_ASSETS_DIR "")
    endif()
  endif()

  if(NOT GENAPK_SHARED_LIBRARY)
    set(GENAPK_SHARED_LIBRARY "$<TARGET_FILE:${GENAPK_TARGET_NAME}>")
  endif()

  if(NOT GENAPK_NDK_ROOT)
    set(_gen_ndk_abs "${GENAPK_FRAMEWORK_ROOT}/ThirdPartyLibraries/android-ndk")
    file(RELATIVE_PATH GENAPK_NDK_ROOT "${GENAPK_OUTPUT_DIR}" "${_gen_ndk_abs}")
  endif()

  if(NOT GENAPK_SDK_ROOT)
    set(_gen_sdk_abs "${GENAPK_FRAMEWORK_ROOT}/ThirdPartyLibraries/android-sdk")
    file(RELATIVE_PATH GENAPK_SDK_ROOT "${GENAPK_OUTPUT_DIR}" "${_gen_sdk_abs}")
  endif()

  if(NOT GENAPK_APP_ID)
    set(GENAPK_APP_ID "com.gen.${GENAPK_PROJECT_NAME}")
  endif()
  if(NOT GENAPK_APP_LABEL)
    set(GENAPK_APP_LABEL "${GENAPK_PROJECT_NAME}")
  endif()
  if(NOT GENAPK_ABI)
    if(DEFINED CMAKE_ANDROID_ARCH_ABI AND NOT "${CMAKE_ANDROID_ARCH_ABI}" STREQUAL "")
      set(GENAPK_ABI "${CMAKE_ANDROID_ARCH_ABI}")
    else()
      set(GENAPK_ABI "arm64-v8a")
    endif()
  endif()

  file(TO_CMAKE_PATH "${GENAPK_NDK_ROOT}" GENAPK_NDK_ROOT)
  file(TO_CMAKE_PATH "${GENAPK_SDK_ROOT}" GENAPK_SDK_ROOT)

  set(_gen_build_script "${GENAPK_FRAMEWORK_ROOT}/Common/cmake/GEN_AndroidPackage_Build.cmake")
  file(TO_CMAKE_PATH "${_gen_build_script}" _gen_build_script)

  set(_gen_guard "GEN_ANDROID_POST_BUILD_ADDED_${GENAPK_TARGET_NAME}")
  get_property(_gen_post_build_added GLOBAL PROPERTY "${_gen_guard}")
  if(NOT _gen_post_build_added)
    set_property(GLOBAL PROPERTY "${_gen_guard}" TRUE)

    add_custom_command(
      TARGET "${GENAPK_TARGET_NAME}" POST_BUILD
      COMMAND "${CMAKE_COMMAND}"
        "-DGEN_ANDROID_SOURCE_ASSETS_DIR=${GENAPK_SOURCE_ASSETS_DIR}"
        "-DGEN_ANDROID_GENERATED_MANIFEST=${GENAPK_GENERATED_MANIFEST}"
        "-DGEN_ANDROID_NDK_ROOT=${GENAPK_NDK_ROOT}"
        "-DGEN_ANDROID_SDK_ROOT=${GENAPK_SDK_ROOT}"
        "-DGEN_ANDROID_JAVA_HOME=${GENAPK_JAVA_HOME}"
        "-DGEN_ANDROID_ABI=${GENAPK_ABI}"
        "-DGEN_ANDROID_TARGET_SDK=${GENAPK_TARGET_SDK}"
        "-DGEN_ANDROID_MIN_SDK=${GENAPK_MIN_SDK}"
        "-DGEN_ANDROID_PROJECT_NAME=${GENAPK_PROJECT_NAME}"
        "-DGEN_ANDROID_APP_ID=${GENAPK_APP_ID}"
        "-DGEN_ANDROID_APP_LABEL=${GENAPK_APP_LABEL}"
        "-DGEN_ANDROID_SHARED_LIBRARY=${GENAPK_SHARED_LIBRARY}"
        "-DGEN_ANDROID_OUTPUT_DIR=${GENAPK_OUTPUT_DIR}"
        -P "${_gen_build_script}"
      VERBATIM
      COMMENT "Generate Android APK for ${GENAPK_PROJECT_NAME}"
    )
  endif()

  set(_gen_apk_target "${GENAPK_PROJECT_NAME}_apk")
  if(NOT TARGET "${_gen_apk_target}")
    add_custom_target("${_gen_apk_target}" DEPENDS "${GENAPK_TARGET_NAME}")
  endif()
endfunction()
