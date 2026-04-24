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


ListContainsSubValue(ISFOUND GEN_SO_THIRDPARTY_LIBRARYS "stdc++")
if(ISFOUND)
  list(APPEND DOCKER_PACKAGES libstdc++6)
endif()

ListContainsSubValue(ISFOUND1 GEN_SO_THIRDPARTY_LIBRARYS "pthread")
ListContainsSubValue(ISFOUND2 GEN_SO_THIRDPARTY_LIBRARYS "rt")
ListContainsSubValue(ISFOUND3 GEN_SO_THIRDPARTY_LIBRARYS "dl")
ListContainsSubValue(ISFOUND4 GEN_SO_THIRDPARTY_LIBRARYS "m")
if(ISFOUND1 OR ISFOUND2 OR ISFOUND3 OR ISFOUND4)
  list(APPEND DOCKER_PACKAGES libc6)
endif()

ListContainsSubValue(ISFOUND GEN_SO_THIRDPARTY_LIBRARYS "atomic")
if(ISFOUND)
  list(APPEND DOCKER_PACKAGES libatomic1)
endif()


ListContainsSubValue(ISFOUND GEN_SO_THIRDPARTY_LIBRARYS "asound")  
if(ISFOUND)
  list(APPEND DOCKER_PACKAGES libasound2t64)
endif()


ListContainsSubValue(ISFOUND GEN_SO_THIRDPARTY_LIBRARYS "udev")
if(ISFOUND)
  list(APPEND DOCKER_PACKAGES libudev1)
endif()


ListContainsSubValue(ISFOUND GEN_SO_THIRDPARTY_LIBRARYS "bluetooth")
if(ISFOUND)
  list(APPEND DOCKER_PACKAGES libbluetooth3)
endif()


ListContainsSubValue(ISFOUND GEN_SO_THIRDPARTY_LIBRARYS "iw")
if(ISFOUND)
  list(APPEND DOCKER_PACKAGES libiw30t64)
endif()


ListContainsSubValue(ISFOUND GEN_SO_THIRDPARTY_LIBRARYS "pcap")
if(ISFOUND)
  list(APPEND DOCKER_PACKAGES libpcap0.8t64)
endif()


ListContainsSubValue(ISFOUND GEN_SO_THIRDPARTY_LIBRARYS "mysqlclient")
if(ISFOUND)
  list(APPEND DOCKER_PACKAGES libmariadb3)
endif()


ListContainsSubValue(ISFOUND GEN_SO_THIRDPARTY_LIBRARYS "pq")
if(ISFOUND)
  list(APPEND DOCKER_PACKAGES libpq5)
endif()


ListContainsSubValue(ISFOUND GEN_SO_THIRDPARTY_LIBRARYS "X11")
if(ISFOUND)
  list(APPEND DOCKER_PACKAGES libx11-6)
endif()


ListContainsSubValue(ISFOUND GEN_SO_THIRDPARTY_LIBRARYS "Xext")
if(ISFOUND)
  list(APPEND DOCKER_PACKAGES libxext6)
endif()


ListContainsSubValue(ISFOUND GEN_SO_THIRDPARTY_LIBRARYS "Xrandr")
if(ISFOUND)
  list(APPEND DOCKER_PACKAGES libxrandr2)
endif()


ListContainsSubValue(ISFOUND GEN_SO_THIRDPARTY_LIBRARYS "Xxf86vm")
if(ISFOUND)
  list(APPEND DOCKER_PACKAGES libxxf86vm1)
endif()


ListContainsSubValue(ISFOUND GEN_SO_THIRDPARTY_LIBRARYS "dbus-1")
if(ISFOUND)
  list(APPEND DOCKER_PACKAGES libdbus-1-3)
endif()


# --------------------------------------------------------------------


set(CMAKE_CREATEDOCKERFILE_CTRL_MSG "by External Config") 
      
if("${CMAKE_CREATEDOCKERFILE_EXTERNAL_CFG}" STREQUAL "CREATEDOCKERFILE")

  option(CMAKE_CREATEDOCKERFILE_CTRL_FEATURE  "Create Dockerfile Ctrl"  ON)
    
else()
  
  if("${CMAKE_CREATEDOCKERFILE_EXTERNAL_CFG}" STREQUAL "NOTCREATEDOCKERFILE")
  
    unset(CMAKE_CREATEDOCKERFILE_CTRL_FEATURE CACHE)

  else()
      
    if(CMAKE_CREATEDOCKERFILE_FEATURE)
        
      option(CMAKE_CREATEDOCKERFILE_CTRL_FEATURE  "Create Dockerfile Ctrl"  ON)
      
    endif()

   set(CMAKE_CREATEDOCKERFILE_CTRL_MSG "by Proyect") 

  endif()
  
endif()


if(NOT DEFINED PATHLISTAPP OR "${PATHLISTAPP}" STREQUAL "")
  set(OUT_DIR "${GEN_DIRECTORY}/Common/Docker")
else()
  set(OUT_DIR "${PATHLISTAPP}../../Docker")
endif()  


if(CMAKE_CREATEDOCKERFILE_CTRL_FEATURE)

  set(LINEFEED " \\
  ")  # end of library


  string(REPLACE ";" "${LINEFEED}" DOCKER_PACKAGES_JOINED "${DOCKER_PACKAGES}")

  #string (JOIN " " DOCKER_PACKAGES_JOINED "${DOCKER_PACKAGES}")
  set(DOCKER_PACKAGES_LINE "${DOCKER_PACKAGES_JOINED}")

  set(DOCKERFILE_OUTPUT "${OUT_DIR}/dockerfile_prod_${CMAKE_PROJECT_NAME}")

  message(STATUS "[ GEN dockerfile + provisioning generated at: dockerfile_prod_${CMAKE_PROJECT_NAME} ]")

  configure_file( "${OUT_DIR}/dockerfile_prod.in"
                  "${DOCKERFILE_OUTPUT}"
                  @ONLY)

  set_property(DIRECTORY APPEND PROPERTY ADDITIONAL_CLEAN_FILES ${DOCKERFILE_OUTPUT})
  
endif()


# --------------------------------------------------------------------