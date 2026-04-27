# --------------------------------------------------------------------
# GEN_Main_DebugMemCtrl.cmake
# Main: Debug management and memory control
# --------------------------------------------------------------------


# --------------------------------------------------------------------
# Debug / Release 

unset(CMAKE_BUILD_TYPE          CACHE)
unset(CMAKE_CONFIGURATION_TYPES CACHE)

set(DEBUG_CTRL_MSG "by External Config") 

if("${DEBUG_EXTCFG}" STREQUAL "DEBUG")

  option(DEBUG_CTRL_FEATURE  "Debug Mode Ctrl"  ON)
    
else()
  
  if("${DEBUG_EXTCFG}" STREQUAL "RELEASE")
  
    unset(DEBUG_CTRL_FEATURE CACHE)
    unset(DEBUG_FEATURE CACHE)

  else()
      
    if(DEBUG_FEATURE)
        
      option(DEBUG_CTRL_FEATURE  "Debug Mode Ctrl"  ON)
      
    endif()

   set(DEBUG_CTRL_MSG "by Proyect") 

  endif()
  
endif()


#if(DEBUG_CTRL_FEATURE AND DEBUG_FEATURE)
if(DEBUG_CTRL_FEATURE)

  # add_definitions(-DGEN_DEBUG)

  set(CMAKE_BUILD_TYPE Debug            CACHE STRING "Choose the type of build."  FORCE)
  set(CMAKE_CONFIGURATION_TYPES Debug   CACHE STRING "Choose the type of build."  FORCE)
    
else()

  add_definitions(-DGEN_NODEBUG)
  
  set(CMAKE_BUILD_TYPE Release          CACHE STRING "Choose the type of build."  FORCE)
  set(CMAKE_CONFIGURATION_TYPES Release CACHE STRING "Choose the type of build."  FORCE)

endif()

message(STATUS "[ GEN Mode application in ${CMAKE_BUILD_TYPE} ${DEBUG_CTRL_MSG} ]")  


# --------------------------------------------------------------------
# Memory control 

set(MEMORY_CTRL_MSG "by External Config") 

if("${MEMORY_EXTCFG}" STREQUAL "MEMCTRL")

  if(DEBUG_CTRL_FEATURE)  
    option(MEMORY_CTRL_FEATURE  "Memory Mode Ctrl"  ON)
  else()
    set(MEMORY_CTRL_MSG "because debug mode is disabled")         
  endif()
    
else()
  
  if("${MEMORY_EXTCFG}" STREQUAL "NOTMEMCTRL")
  
    unset(MEMORY_CTRL_FEATURE CACHE)

  else()
      
    if(XMEMORY_CONTROL_FEATURE)
        
      if(DEBUG_CTRL_FEATURE)        
        option(MEMORY_CTRL_FEATURE  "Memory Mode Ctrl"  ON)
        set(MEMORY_CTRL_MSG "by Proyect")         
      else()    
        set(MEMORY_CTRL_MSG "because debug mode is disabled")         
      endif()
      
    endif()

  endif()
  
endif()


#if(MEMORY_CTRL_FEATURE AND XMEMORY_CONTROL_FEATURE)
if(MEMORY_CTRL_FEATURE)

  add_definitions(-DXMEMORY_CONTROL_ACTIVE)

  list(APPEND GEN_SOURCES_MODULES_LIST "${GEN_DIRECTORY_SOURCES_XUTILS}/XMemory_Control.cpp")
  
  message(STATUS "[ GEN Memory Control: Active ${MEMORY_CTRL_MSG} ]")  
  
else()  

  message(STATUS "[ GEN Memory Control: Deactive ${MEMORY_CTRL_MSG} ]")  
 
endif()


# --------------------------------------------------------------------
# Trace control 

set(TRACE_CTRL_MSG "by External Config") 

if("${TRACE_EXTCFG}" STREQUAL "TRACE")

  option(XTRACE_FEATURE                                         "XTrace"                                                  ON )  
    
else()

  if("${TRACE_EXTCFG}" STREQUAL "TRACENOTINTER")
    
    option(XTRACE_FEATURE                                       "XTrace"                                                  ON )  
    option(XTRACE_NOINTERNET_FEATURE                            "No need for trace dependencies with Internet"            ON )   

  else()
      
    if("${TRACE_EXTCFG}" STREQUAL "NOTTRACE")
  
      unset(XTRACE_FEATURE             CACHE)
      unset(XTRACE_NOINTERNET_FEATURE  CACHE)     
           
    else()      
            
      set(TRACE_CTRL_MSG "by Proyect") 
         
    endif()
  
  endif()
  
endif()


if(XTRACE_NOINTERNET_FEATURE)

  message(STATUS "[ GEN Trace Control: Active without Internet specified ${TRACE_CTRL_MSG} ]")  
 
else()

  if(XTRACE_FEATURE)

    message(STATUS "[ GEN Trace Control: Active ${TRACE_CTRL_MSG} ]")  
 
  else()
  
    message(STATUS "[ GEN Trace Control: Deactive ${TRACE_CTRL_MSG} ]")  
   
  endif()

endif() 
 

if(XTRACE_FEATURE)

  add_definitions(-DXTRACE_ACTIVE)

  if(XTRACE_NOINTERNET_FEATURE)
  
    add_definitions(-DXTRACE_NOINTERNET)  
    
  else()

    option(DIO_PUBLICINTERNETIP_FEATURE                         "Public Internet IP"                                      ON )

  endif()
 
  if(COMPILE_FOR_WINDOWS OR COMPILE_FOR_LINUX OR COMPILE_FOR_ANDROID32 OR COMPILE_FOR_ANDROID64)
  
    option(DIO_FEATURE                                          "Data Input/Output"                                       ON )
    option(DIO_DNSRESOLVER_FEATURE                              "DNS Resolver"                                            ON )
   #option(DIO_WEBCLIENT_FEATURE                                "Web Client"                                              ON )
    
  endif()

endif()  


# --------------------------------------------------------------------
# Feedback control 

set(FEEDBACK_CTRL_MSG "by External Config") 

if("${FEEDBACK_EXTCFG}" STREQUAL "FEEDBACK")

  option(XFEEDBACK_CTRL_FEATURE  "XFeedback Ctrl" ON )     
  option(XFEEDBACK_CONTROL_FEATURE                           "XFeedback Control"                                  ON )               
    
else()

  if("${FEEDBACK_EXTCFG}" STREQUAL "NOTFEEDBACK")
  
    unset(XFEEDBACK_CTRL_FEATURE CACHE)                 
    unset(XFEEDBACK_CONTROL_FEATURE CACHE)

  else()
              
    if(XFEEDBACK_CONTROL_FEATURE)

      option(XFEEDBACK_CTRL_FEATURE  "XFeedback Ctrl" ON ) 

    endif()

    set(FEEDBACK_CTRL_MSG "by Proyect") 
    
  endif()
  
endif()


#if(XFEEDBACK_CTRL_FEATURE AND XFEEDBACK_CONTROL_FEATURE)
if(XFEEDBACK_CTRL_FEATURE)

  add_definitions(-DXFEEDBACK_CONTROL_ACTIVE)
  list(APPEND GEN_SOURCES_MODULES_LIST "${GEN_DIRECTORY_SOURCES_XUTILS}/XFeedback_Control.cpp")
  
  message(STATUS "[ GEN Feedback Control: Active ${FEEDBACK_CTRL_MSG} ]")  

else()

  message(STATUS "[ GEN Feedback Control: Deactive ${FEEDBACK_CTRL_MSG} ]")  

endif()


