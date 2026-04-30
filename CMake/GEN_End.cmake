# --------------------------------------------------------------------
# GEN_End.cmake
# End of GEN CMakes
# --------------------------------------------------------------------


# --------------------------------------------------------------------
# Create proyect 
include("${GEN_DIRECTORY}/Common/CMake/Main/GEN_Main_CreateProject.cmake")


# --------------------------------------------------------------------
# Add Libraries
include("${GEN_DIRECTORY}/Common/CMake/Main/GEN_Main_Libraries.cmake") 


# --------------------------------------------------------------------
# Generated Coverage
include("${GEN_DIRECTORY}/Common/CMake/Main/GEN_Main_CoverageGenerate.cmake") 


message(STATUS "[GEN]-------------------------------------------------------------------------------------------------------------------------------------[GEN]")

unset(DEBUG_CTRL_FEATURE CACHE)
unset(MEMORY_CONTROL_FEATURE CACHE)

option(GEN_DETECT_PLATFORM_COMPILER                           "Detect platform compiler"                                  OFF )
unset(GEN_DETECT_PLATFORM_COMPILER CACHE)
 
