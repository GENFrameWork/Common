# --------------------------------------------------------------------*
# GEN_Main_GenerateCoverage.cmake 
# --------------------------------------------------------------------


function(GEN_List_All_Tests)

    get_property(ALL_TESTS DIRECTORY PROPERTY TESTS)
    
    foreach(t ${ALL_TESTS})
    
        get_test_property(CMD ${t} COMMAND)
        list(APPEND ALLTESTS "${t}")
        
    endforeach()

    string(REPLACE ";" ", " _ALLTESTS "${ALLTESTS}")
     
    message(STATUS "[ GEN List of registered tests: ${ALLTESTS} ]")
    
endfunction()

              
if(COVERAGE_GENERATESHOWINFO_FEATURE)  

  set(TARGET_LOWERCASE "${TARGET}")
  string(TOLOWER "${TARGET_LOWERCASE}" TARGET_LOWERCASE)
    
  set(MODE_COMPILE "RELEASE")
  
  if(DEBUG_CTRL_FEATURE)  
    set(MODE_COMPILE "DEBUG")    
  endif()

  set(PLATFORMS_SYSTEM_NAME "CMake/Build/${CMAKE_SYSTEM_NAME}")

  set(GEN_DIR_BIN_ABSOLUTE                      "${CMAKE_BINARY_DIR}")    

  get_filename_component(GEN_DIR_ABSOLUTE       "${GEN_DIR_BIN_ABSOLUTE}/../../../../../.." ABSOLUTE)
  get_filename_component(GEN_DIR_APP_ABSOLUTE   "${GEN_DIR_BIN_ABSOLUTE}/../../../.."      ABSOLUTE)
   
  set(GEN_DIR_TEST                              "${GEN_DIR_ABSOLUTE}/Tests")
  
  set(GEN_DIR_TEST_XUTILS_UNITTESTS             "${GEN_DIR_TEST}/XUtils_UnitTests")                                                                       
  set(GEN_DIR_TEST_XUTILS_UNITTESTS_BIN         "${GEN_DIR_TEST_XUTILS_UNITTESTS}/${PLATFORMS_SYSTEM_NAME}/${TARGET_LOWERCASE}")

  set(GEN_DIR_TEST_PROJECT                      "${GEN_DIR_TEST}/${CMAKE_PROJECT_NAME}_unittests")
  set(GEN_DIR_TEST_PROJECT_BIN                  "${GEN_DIR_TEST_PROJECT}/${PLATFORMS_SYSTEM_NAME}/${TARGET_LOWERCASE}/${CMAKE_PROJECT_NAME}_unittests")
    
  # message(STATUS "GEN_DIR_ABSOLUTE                  : ${GEN_DIR_ABSOLUTE}")
  # message(STATUS "GEN_DIR_BIN_ABSOLUTE              : ${GEN_DIR_BIN_ABSOLUTE}") 
  # message(STATUS "GEN_DIR_APP_ABSOLUTE              : ${GEN_DIR_APP_ABSOLUTE}")  
  # message(STATUS "GEN_DIR_TEST                      : ${GEN_DIR_TEST}")  
  # message(STATUS "GEN_DIR_TEST_XUTILS_UNITTESTS     : ${GEN_DIR_TEST_XUTILS_UNITTESTS}")
  # message(STATUS "GEN_DIR_TEST_XUTILS_UNITTESTS_BIN : ${GEN_DIR_TEST_XUTILS_UNITTESTS_BIN}")
  # message(STATUS "GEN_DIR_TEST_PROJECT              : ${GEN_DIR_TEST_PROJECT}")
  # message(STATUS "GEN_DIR_TEST_PROJECT_BIN          : ${GEN_DIR_TEST_PROJECT_BIN}")
  # message(STATUS "EXEC APP                          : ${GEN_DIR_BIN_ABSOLUTE}/${CMAKE_PROJECT_NAME}")
  # message(STATUS "TARGET & MODE COMPILE             : ${TARGET_LOWERCASE} - ${MODE_COMPILE}")
  
  
  set(GCOVR_SEARCH_DIRS "")


  if (EXISTS "${GEN_DIR_TEST_XUTILS_UNITTESTS}")
    list(APPEND GCOVR_SEARCH_DIRS "${GEN_DIR_TEST_XUTILS_UNITTESTS}")
  endif()

  if (EXISTS "${GEN_DIR_TEST_XUTILS_UNITTESTS_BIN}")
    list(APPEND GCOVR_SEARCH_DIRS "${GEN_DIR_TEST_XUTILS_UNITTESTS_BIN}")
  endif()

  if(EXISTS "${GEN_DIR_TEST_PROJECT_BIN}")
    list(APPEND GCOVR_SEARCH_DIRS "${GEN_DIR_TEST_PROJECT_BIN}")
  endif()

  if(EXISTS "${GEN_DIR_BIN_ABSOLUTE}")
      list(APPEND GCOVR_SEARCH_DIRS "${GEN_DIR_BIN_ABSOLUTE}")
  endif()


  enable_testing()
       
  if (EXISTS "${GEN_DIR_TEST_XUTILS_UNITTESTS_BIN}/xutils_unittests")     
    add_test(NAME xutils_unittests COMMAND "${GEN_DIR_TEST_XUTILS_UNITTESTS_BIN}/xutils_unittests")    
  endif()  
    
  if(EXISTS "${GEN_DIR_TEST_PROJECT_BIN}")
    add_test(NAME ${CMAKE_PROJECT_NAME}_unittest COMMAND "${GEN_DIR_TEST_PROJECT_BIN}")    
  endif()
 
  GEN_List_All_Tests()

    
  if(COMPILE_WITH_GCC)
  
    find_program(GCOVR gcovr)

      add_custom_target( generate_coverage_html
      
                       #COMMAND ${CMAKE_COMMAND} -E echo "Running application briefly to generate .gcda files... "
                       #COMMAND timeout 30s script -q -c "\"${GEN_DIR_BIN_ABSOLUTE}/${CMAKE_PROJECT_NAME}\"" /dev/null                          
                       #COMMAND bash "${GEN_DIR_ABSOLUTE}/Common/Scripts/compile/epics_run_app_short.bash" "${GEN_DIR_BIN_ABSOLUTE}/${CMAKE_PROJECT_NAME}"

                        COMMAND ${CMAKE_CTEST_COMMAND} || true

                        COMMAND ${GCOVR}
                            --root "${GEN_DIR_ABSOLUTE}"
                            --object-directory "${GEN_DIR_BIN_ABSOLUTE}"
                            --filter "${GEN_DIR_APP_ABSOLUTE}"
                            --filter "${GEN_DIR_TEST_XUTILS_UNITTESTS}"
                            --filter "${GEN_DIR_TEST_PROJECT}"
                            ${GCOVR_SEARCH_DIRS}
                            --html --html-details -o coverage.html
                        
                        WORKING_DIRECTORY ${GEN_DIR_BIN_ABSOLUTE}
                      )

      if(COMPILE_ON_WSL_LINUX)

        execute_process(COMMAND wslpath -w "${GEN_DIR_BIN_ABSOLUTE}/coverage.html" 
                        OUTPUT_VARIABLE COVERAGE_WIN_PATH
                        OUTPUT_STRIP_TRAILING_WHITESPACE
                       )
                 
        add_custom_command(TARGET generate_coverage_html POST_BUILD COMMAND /mnt/c/Windows/System32/cmd.exe /C start \"\" \"${COVERAGE_WIN_PATH}\" || true)
 
      endif()
      
  endif()                  

endif()



