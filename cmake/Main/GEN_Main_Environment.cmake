#-----------------------------------------------------------------------------
# GEN_Environment.cmake
# 
# This script sets up the environment variables for the GEN Framework,
# specifically focusing on Android NDK/SDK location within ThirdPartyLibraries.
#-----------------------------------------------------------------------------

if(ANDROID)

  # Forzamos a que la ruta sea absoluta desde el principio
  get_filename_component(GEN_THIRDPARTY_LIBRARIES_DIR "${GEN_DIRECTORY}/ThirdPartyLibraries" ABSOLUTE)

  #-----------------------------------------------------------------------------
  # Android NDK Configuration
  
  if(NOT DEFINED ANDROID_NDK)
    set(ANDROID_NDK "${GEN_THIRDPARTY_LIBRARIES_DIR}/android-ndk" CACHE PATH "GEN: Path to Android NDK" FORCE)
  endif()

  #-----------------------------------------------------------------------------
  # Android SDK Configuration
  
  if(NOT DEFINED ANDROID_SDK)
    set(ANDROID_SDK "${GEN_THIRDPARTY_LIBRARIES_DIR}/android-sdk" CACHE PATH "GEN: Path to Android SDK" FORCE)
  endif()

  #-----------------------------------------------------------------------------
  # Validation and Toolchain Force
  
  if(EXISTS "${ANDROID_NDK}")
    # Force the CMake Toolchain to use the NDK provided in ThirdPartyLibraries
    set(CMAKE_TOOLCHAIN_FILE "${ANDROID_NDK}/build/CMake/android.toolchain.cmake" CACHE FILEPATH "" FORCE)
    
    message(STATUS "[ GEN Android Environment detected:")
    message(STATUS "      > NDK: ${ANDROID_NDK}")
    message(STATUS "      > SDK: ${ANDROID_SDK} ]")
  else()
    message(FATAL_ERROR "[GEN  Error: Android NDK not found at ${ANDROID_NDK}. Please check ThirdPartyLibraries folder. ]")
  endif()

endif()

#-----------------------------------------------------------------------------