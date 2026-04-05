# --------------------------------------------------------------------
# GEN_Main_CoverageCreateInfo.cmake 
# --------------------------------------------------------------------



set(COVERAGE_CREATEINFO_CTRL_MSG "by External Config") 

if("${COVERAGE_CREATEINFO_EXTERNAL_CFG}" STREQUAL "COVER")

  option(COVERAGE_CREATEINFO_CTRL_FEATURE  "Coverture Award test Ctrl"  ON)
    
else()
  
  if("${COVERAGE_CREATEINFO_EXTERNAL_CFG}" STREQUAL "NOTCOVER")
  
    unset(COVERAGE_CREATEINFO_CTRL_FEATURE CACHE)

  else()
      
    if(COVERAGE_CREATEINFO_FEATURE)
        
      option(COVERAGE_CREATEINFO_CTRL_FEATURE  "Coverture Award test Ctrl"  ON)
      
    endif()

   set(COVERAGE_CREATEINFO_CTRL_MSG "by Proyect") 

  endif()
  
endif()



if(COVERAGE_CREATEINFO_CTRL_FEATURE)  

  add_definitions(-DCOVERAGE_CREATEINFO_ACTIVE)

  if(COMPILE_WITH_GCC)
  
    message(STATUS "[ GEN COVERAGE Create info enabled for GCC compiler ${COVERAGE_CREATEINFO_CTRL_MSG} ]")

    add_compile_options(--coverage -O0 -g)
    add_link_options(--coverage)
    
    elseif(COMPILE_WITH_CLANG OR COMPILE_WITH_CLANG_CL)
         
          message(STATUS "[ GEN COVERAGE Create info enabled for Clang compiler ${COVERAGE_CREATEINFO_CTRL_MSG} }")

          add_compile_options(-fprofile-instr-generate -fcoverage-mapping -O0 -g)
          add_link_options(-fprofile-instr-generate)
        
        else()      
      
          message(STATUS "[ GEN COVERAGE Create info is enabled ${COVERAGE_CREATEINFO_CTRL_MSG} (compiler is not supported) ]")
        
        endif()
        
else()        

  message(STATUS "[ GEN COVERAGE Create info is disabled ${COVERAGE_CREATEINFO_CTRL_MSG} ]")
   
endif()




