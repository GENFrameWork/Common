# --------------------------------------------------------------------
# GEN_Main_LibraryProvisioning.cmake
# Main: Library Provisioning
#
# --------------------------------------------------------------------


# --------------------------------------------------------------------

function(ListContainsValue RESULT LIST_NAME SEARCH_VALUE)

  set(found FALSE)
  
  foreach(elem IN LISTS ${LIST_NAME})
      if("${elem}" STREQUAL "${SEARCH_VALUE}")
          set(found TRUE)
          break()
      endif()
  endforeach()
  
  set(${RESULT} ${found} PARENT_SCOPE)

endfunction()



function(ListContainsSubValue RESULT LIST_NAME SEARCH_VALUE)

  set(found FALSE)
  
  foreach(elem IN LISTS ${LIST_NAME})
      string(FIND "${elem}" "${SEARCH_VALUE}" pos)
      if(NOT pos EQUAL -1)
          set(found TRUE)
          break()
      endif()
  endforeach()
  
  set(${RESULT} ${found} PARENT_SCOPE)

endfunction()


# --------------------------------------------------------------------


# List of packages to install (default APT names)
set(DOCKER_PACKAGES bash)

list(APPEND DOCKER_PACKAGES libstdc++6)
list(APPEND DOCKER_PACKAGES libgcc-s1)


# hiredis
ListContainsSubValue(ISFOUND GEN_COMPILED_THIRDPARTYLIBRARIES "AGG")
if(ISFOUND)
  
  list(APPEND DOCKER_PACKAGES libhiredis1.1.0=1.2.0-6+b3)

endif()


# --------------------------------------------------------------------


set(LINEFEED " \\
")  # end of library


string(REPLACE ";" "${LINEFEED}" DOCKER_PACKAGES_JOINED "${DOCKER_PACKAGES}")

#string (JOIN " " DOCKER_PACKAGES_JOINED "${DOCKER_PACKAGES}")
set(DOCKER_PACKAGES_LINE "${DOCKER_PACKAGES_JOINED}")


set(OUT_DIR "${GEN_DIRECTORY}/Common/docker")

set(DOCKERFILE_OUTPUT "${OUT_DIR}/dockerfile_prod_${CMAKE_PROJECT_NAME}")

message(STATUS "[ GEN dockerfile + provisioning generated at: dockerfile_prod_${CMAKE_PROJECT_NAME} ]")

configure_file( "${OUT_DIR}/dockerfile_prod.in"
                "${DOCKERFILE_OUTPUT}"
                @ONLY)

set_property(DIRECTORY APPEND PROPERTY ADDITIONAL_CLEAN_FILES ${DOCKERFILE_OUTPUT})


# --------------------------------------------------------------------