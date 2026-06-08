# --------------------------------------------------------------------
# GEN_Main_Compiler_Windows.cmake
# Main: Windows Compiler
# --------------------------------------------------------------------


add_definitions(-D_CRT_SECURE_NO_WARNINGS)
add_compile_options(/utf-8)

set(CMAKE_RC_COMPILER rc.exe CACHE FILEPATH "" FORCE)
  
if(USE_CLANG_CTRL_FEATURE)
 
  set(CMAKE_C_COMPILER   clang-cl CACHE FILEPATH "" FORCE)
  set(CMAKE_CXX_COMPILER clang-cl CACHE FILEPATH "" FORCE)

  add_compile_definitions(NOMINMAX)
  string(APPEND CMAKE_C_FLAGS   " /DNOMINMAX")
  string(APPEND CMAKE_CXX_FLAGS " /DNOMINMAX")


  if(COMPILE_FOR_WINDOWS_INTEL_32)

    add_compile_options(/clang:-m32)
    add_link_options(/MACHINE:X86)

  endif()


  if(COMPILE_FOR_WINDOWS_INTEL_64)

    add_compile_options(/clang:-m64)
    add_link_options(/MACHINE:X64)

  endif()


else()

 
  if(WINDOWS_APPMODE_DINAMIC)

    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDLL$<$<CONFIG:Debug>:Debug>")

  else()

    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

  endif()

endif()