# --------------------------------------------------------------------
# GEN_Main_Compiler_Windows.cmake
# Main: Windows Compiler
# --------------------------------------------------------------------


add_definitions(-D_CRT_SECURE_NO_WARNINGS)

# /utf-8 sets both source and execution charset to UTF-8.
# Required for MSVC and clang-cl from fmt v11 onwards (bundled in
# openal-soft): fmt/base.h has a static_assert that fails without it.
# Safe to apply globally: only affects string literal encoding.
add_compile_options(/utf-8)

set(CMAKE_RC_COMPILER rc.exe CACHE FILEPATH "" FORCE)
  
if(USE_CLANG_CTRL_FEATURE)
 
  set(CMAKE_C_COMPILER   clang-cl CACHE FILEPATH "" FORCE)
  set(CMAKE_CXX_COMPILER clang-cl CACHE FILEPATH "" FORCE)

  
  # NOMINMAX: stop <windows.h> (minwindef.h) from defining min()/max() macros,
  # which collide with std::numeric_limits<>::max(), std::max() and ANGLE.
  #
  # NOTE: do NOT define WIN32_LEAN_AND_MEAN here. It makes <windows.h> skip the
  # "less common" sub-headers (winperf.h, shellapi.h, ...), and GEN relies on
  # them: XWINDOWSSystem.h uses PERF_DATA_BLOCK / PPERF_OBJECT_TYPE /
  # PPERF_COUNTER_DEFINITION / PPERF_INSTANCE_DEFINITION (winperf.h) and
  # MainProcWINDOWS.cpp uses CommandLineToArgvW (shellapi.h). Defining it broke
  # those translation units. NOMINMAX alone fixes ANGLE without that fallout.
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