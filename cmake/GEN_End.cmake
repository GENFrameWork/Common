# --------------------------------------------------------------------
# GEN_End.cmake
# End of GEN CMakes
# --------------------------------------------------------------------


# --------------------------------------------------------------------
# Create proyect 
include("${GEN_DIRECTORY}/Common/cmake/GEN_CreateProject.cmake")


# --------------------------------------------------------------------
# Add Libraries
include("${GEN_DIRECTORY}/Common/cmake/GEN_Libraries.cmake") 


message(STATUS "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------")

unset(DEBUG_CTRL_FEATURE CACHE)
unset(MEMORY_CONTROL_FEATURE CACHE)

option(GEN_DETECT_PLATFORM_COMPILER                           "Detect platform compiler"                                  OFF )
unset(GEN_DETECT_PLATFORM_COMPILER CACHE)
 
