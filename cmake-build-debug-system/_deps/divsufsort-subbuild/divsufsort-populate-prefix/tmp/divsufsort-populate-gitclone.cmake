
if(NOT "/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-subbuild/divsufsort-populate-prefix/src/divsufsort-populate-stamp/divsufsort-populate-gitinfo.txt" IS_NEWER_THAN "/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-subbuild/divsufsort-populate-prefix/src/divsufsort-populate-stamp/divsufsort-populate-gitclone-lastrun.txt")
  message(STATUS "Avoiding repeated git clone, stamp file is up to date: '/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-subbuild/divsufsort-populate-prefix/src/divsufsort-populate-stamp/divsufsort-populate-gitclone-lastrun.txt'")
  return()
endif()

execute_process(
  COMMAND ${CMAKE_COMMAND} -E rm -rf "/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-src"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to remove directory: '/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-src'")
endif()

# try the clone 3 times in case there is an odd git clone issue
set(error_code 1)
set(number_of_tries 0)
while(error_code AND number_of_tries LESS 3)
  execute_process(
    COMMAND "/usr/bin/git"  clone --no-checkout --config "advice.detachedHead=false" "https://github.com/simongog/libdivsufsort.git" "divsufsort-src"
    WORKING_DIRECTORY "/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps"
    RESULT_VARIABLE error_code
    )
  math(EXPR number_of_tries "${number_of_tries} + 1")
endwhile()
if(number_of_tries GREATER 1)
  message(STATUS "Had to git clone more than once:
          ${number_of_tries} times.")
endif()
if(error_code)
  message(FATAL_ERROR "Failed to clone repository: 'https://github.com/simongog/libdivsufsort.git'")
endif()

execute_process(
  COMMAND "/usr/bin/git"  checkout 2.0.1 --
  WORKING_DIRECTORY "/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-src"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to checkout tag: '2.0.1'")
endif()

set(init_submodules TRUE)
if(init_submodules)
  execute_process(
    COMMAND "/usr/bin/git"  submodule update --recursive --init 
    WORKING_DIRECTORY "/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-src"
    RESULT_VARIABLE error_code
    )
endif()
if(error_code)
  message(FATAL_ERROR "Failed to update submodules in: '/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-src'")
endif()

# Complete success, update the script-last-run stamp file:
#
execute_process(
  COMMAND ${CMAKE_COMMAND} -E copy
    "/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-subbuild/divsufsort-populate-prefix/src/divsufsort-populate-stamp/divsufsort-populate-gitinfo.txt"
    "/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-subbuild/divsufsort-populate-prefix/src/divsufsort-populate-stamp/divsufsort-populate-gitclone-lastrun.txt"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to copy script-last-run stamp file: '/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-subbuild/divsufsort-populate-prefix/src/divsufsort-populate-stamp/divsufsort-populate-gitclone-lastrun.txt'")
endif()

