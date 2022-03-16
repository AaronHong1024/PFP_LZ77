# Install script for directory: /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-src

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-build/sdsl-lite.pc")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-build/external/cmake_install.cmake")
  include("/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-build/include/cmake_install.cmake")
  include("/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-build/lib/cmake_install.cmake")
  include("/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-build/test/cmake_install.cmake")

endif()

