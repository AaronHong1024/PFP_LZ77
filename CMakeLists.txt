CMAKE_MINIMUM_REQUIRED(VERSION 3.15)
SET(CMAKE_BUILD_TYPE "Release")
# Set a default build type if none was specified
# ------------------------------------------------------------------------------
if(NOT CMAKE_BUILD_TYPE)
  message(STATUS "Setting build type to 'Release' as none was specified.")
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build." FORCE)
endif()

message(STATUS "Install directory: ${CMAKE_INSTALL_PREFIX}")

# About this project
# ------------------------------------------------------------------------------
project(pfp-cst)
SET(VERSION_MAJOR "0")
SET(VERSION_MINOR "1")
SET(VERSION_PATCH "0")
SET(VERSION "${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}")

# Set environment
# ------------------------------------------------------------------------------
set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/install)


find_package(Git)
if(GIT_FOUND)
    message("git found: ${GIT_EXECUTABLE}")
else()
    message(WARNING "git not found. Cloning of submodules will not work.")
endif()



# Configure thirdparty
# ------------------------------------------------------------------------------
set(CMAKE_INSTALL_INCLUDEDIR "include") # This is an hack because include(GUIInstallDirs) doesn't work

include(FetchContent)

## Add Big-BWT
FetchContent_Declare(
  bigbwt
  GIT_REPOSITORY https://github.com/alshai/Big-BWT.git
  )
  
FetchContent_GetProperties(bigbwt)
if(NOT bigbwt_POPULATED)
  FetchContent_Populate(bigbwt)
  add_subdirectory(${bigbwt_SOURCE_DIR} ${bigbwt_BINARY_DIR})

  add_library(malloc_count OBJECT ${bigbwt_SOURCE_DIR}/malloc_count.c ${bigbwt_SOURCE_DIR}/malloc_count.h)
  target_link_libraries(malloc_count dl)
  target_include_directories(malloc_count PUBLIC "${bigbwt_SOURCE_DIR}")
  
  endif()
  
## Add gsacak
FetchContent_Declare(
  gsacak
  GIT_REPOSITORY https://github.com/felipelouza/gsa-is.git
)

FetchContent_GetProperties(gsacak)
if(NOT gsacak_POPULATED)
    FetchContent_Populate(gsacak)
    add_library(gsacak OBJECT ${gsacak_SOURCE_DIR}/gsacak.c ${gsacak_SOURCE_DIR}/gsacak.h)
    target_include_directories(gsacak PUBLIC "${gsacak_SOURCE_DIR}")
    
    add_library(gsacak64 OBJECT ${gsacak_SOURCE_DIR}/gsacak.c ${gsacak_SOURCE_DIR}/gsacak.h)
    target_include_directories(gsacak64 PUBLIC "${gsacak_SOURCE_DIR}")
    target_compile_options(gsacak64 PUBLIC -DM64)
endif()


## Add sdsl
FetchContent_Declare(
  sdsl
  GIT_REPOSITORY https://github.com/simongog/sdsl-lite
)

FetchContent_GetProperties(sdsl)
if(NOT sdsl_POPULATED)
  FetchContent_Populate(sdsl)

  set(GENERATE_DOC OFF CACHE BOOL "Do not generate doxygen for sdsl-lite")
  
  add_subdirectory(${sdsl_SOURCE_DIR} ${sdsl_BINARY_DIR} EXCLUDE_FROM_ALL)
endif()

## Add divsuffsort
FetchContent_Declare(
  divsufsort
  GIT_REPOSITORY https://github.com/simongog/libdivsufsort.git
  GIT_TAG        2.0.1
)

FetchContent_GetProperties(divsufsort)
if(NOT divsufsort_POPULATED)
  FetchContent_Populate(divsufsort)

  set(BUILD_SHARED_LIBS OFF CACHE BOOL "Do not build a shared library for libdivsufsort")
  set(BUILD_EXAMPLES OFF CACHE BOOL "Do not build libdivsufsort example")
  set(BUILD_DIVSUFSORT64 ON CACHE BOOL "Build libdivsufsort in 64-bits mode")

  add_subdirectory(${divsufsort_SOURCE_DIR} ${divsufsort_BINARY_DIR} EXCLUDE_FROM_ALL)

  target_include_directories(divsufsort PUBLIC "${divsufsort_BINARY_DIR}/include")
  target_include_directories(divsufsort64 PUBLIC "${divsufsort_BINARY_DIR}/include")
endif()

# Configure the compiler with the appropriate flags
# ------------------------------------------------------------------------------
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang" OR "${CMAKE_CXX_COMPILER_ID}" STREQUAL "AppleClang")
  # using Clang
  # ##############################################################################
  # Compiler configuration
  # @author Massimiliano Rossi
  # ##############################################################################

  # Add the basic compiler options
  add_compile_options("-std=c++14")
  # add_compile_options("-Werror")
  add_compile_options("-Wall")
  add_compile_options("-Wextra")
  add_compile_options("-Wcomment")
  add_compile_options("-Wformat=2")
  add_compile_options("-Wnonnull")
  add_compile_options("-Winit-self")
  add_compile_options("-Wmain")
  add_compile_options("-Wmissing-braces")
  add_compile_options("-Wmissing-include-dirs")
  add_compile_options("-Wparentheses")
  add_compile_options("-Wsequence-point")
  add_compile_options("-Wreturn-type")
  add_compile_options("-Wdate-time")
  add_compile_options("-Wswitch")
  add_compile_options("-Wswitch-default")
  add_compile_options("-Wswitch-enum")
  add_compile_options("-Wunused-function")
  add_compile_options("-Wunused-label")
  add_compile_options("-Wunused-local-typedefs")
  add_compile_options("-Wunused-parameter")
  add_compile_options("-Wunused-variable")
  add_compile_options("-Wunused-value")
  add_compile_options("-Wunused")
  add_compile_options("-Wuninitialized")
  add_compile_options("-Wunknown-pragmas")
  add_compile_options("-Wstrict-aliasing")
  add_compile_options("-Wstrict-overflow=5")
  add_compile_options("-Warray-bounds")
  add_compile_options("-Wundef")
  add_compile_options("-Wendif-labels")
  add_compile_options("-Wshadow")
  add_compile_options("-Wpointer-arith")
  add_compile_options("-Wtype-limits")
  add_compile_options("-Wcast-qual")
  add_compile_options("-Wwrite-strings")
  add_compile_options("-Wconversion")
  add_compile_options("-Wenum-compare")
  add_compile_options("-Wsign-compare")
  add_compile_options("-Waddress")
  add_compile_options("-Wattributes")
  add_compile_options("-Wbuiltin-macro-redefined")
  add_compile_options("-Wmissing-declarations")
  add_compile_options("-Wmissing-field-initializers")
  add_compile_options("-Wdeprecated")
  add_compile_options("-Wdeprecated-declarations")
  add_compile_options("-Woverflow")
  add_compile_options("-Wpacked")
  add_compile_options("-Winline")
  add_compile_options("-Wint-to-pointer-cast")
  add_compile_options("-Winvalid-pch")
  add_compile_options("-Wno-long-long")
  add_compile_options("-Wno-variadic-macros")
  add_compile_options("-Wvarargs")
  add_compile_options("-Wvla")
  add_compile_options("-Wvolatile-register-var")
  add_compile_options("-Wdisabled-optimization")
  add_compile_options("-Wstack-protector")
  add_compile_options("-Woverlength-strings")
  add_compile_options("-fvisibility=hidden")
  add_compile_options("-Wc++11-compat")
  add_compile_options("-Wconversion-null")
  add_compile_options("-Winherited-variadic-ctor")
  add_compile_options("-Winvalid-offsetof")
  add_compile_options("-pedantic")
  add_compile_options("-fno-gnu-keywords")
  add_compile_options("-Wctor-dtor-privacy")
  add_compile_options("-Wdelete-non-virtual-dtor")
  add_compile_options("-Wnarrowing")
  add_compile_options("-Wnon-virtual-dtor")
  add_compile_options("-Wreorder")
  add_compile_options("-Weffc++")
  add_compile_options("-Wold-style-cast")
  add_compile_options("-Wsign-promo")
  add_compile_options("-Wchar-subscripts")
  add_compile_options("-Wno-ignored-qualifiers")
  add_compile_options("-Wuninitialized")
  add_compile_options("-Wdiv-by-zero")
  add_compile_options("-Wfloat-equal")
  add_compile_options("-Wcast-align")
  add_compile_options("-Wempty-body")
  add_compile_options("-Wsizeof-pointer-memaccess")
  add_compile_options("-Wmultichar")
  add_compile_options("-fPIC")

  # Add the basic compiler options for debug version
  set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -ggdb3")
  # Add the basic compiler options for release version
  set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -ansi -march=native -funroll-loops -O3 -DNDEBUG")

elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
  # using GCC
  # ##############################################################################
  # Compiler configuration
  # @author Massimiliano Rossi
  # ##############################################################################

  # Add the basic compiler options
  add_compile_options("-std=c++14")
  # add_compile_options("-Werror")
  add_compile_options("-Wall")
  add_compile_options("-Wextra")
  add_compile_options("-Wcomment")
  add_compile_options("-Wdouble-promotion")
  add_compile_options("-Wformat=2")
  add_compile_options("-Wnonnull")
  add_compile_options("-Winit-self")
  add_compile_options("-Wmain")
  add_compile_options("-Wmissing-braces")
  add_compile_options("-Wmissing-include-dirs")
  add_compile_options("-Wparentheses")
  add_compile_options("-Wsequence-point")
  add_compile_options("-Wreturn-local-addr")
  add_compile_options("-Wreturn-type")
  add_compile_options("-Wswitch")
  add_compile_options("-Wswitch-default")
  add_compile_options("-Wswitch-enum")
  add_compile_options("-Wunused-but-set-parameter")
  add_compile_options("-Wunused-but-set-variable")
  add_compile_options("-Wunused-function")
  add_compile_options("-Wunused-label")
  add_compile_options("-Wunused-local-typedefs")
  add_compile_options("-Wunused-parameter")
  add_compile_options("-Wunused-variable")
  add_compile_options("-Wunused-value")
  add_compile_options("-Wunused")
  add_compile_options("-Wuninitialized")
  add_compile_options("-Wunknown-pragmas")
  add_compile_options("-Wstrict-aliasing")
  add_compile_options("-Wstrict-overflow=5")
  add_compile_options("-Warray-bounds")
  add_compile_options("-Wundef")
  add_compile_options("-Wendif-labels")
  add_compile_options("-Wshadow")
  add_compile_options("-Wfree-nonheap-object")
  add_compile_options("-Wunsafe-loop-optimizations")
  add_compile_options("-Wpointer-arith")
  add_compile_options("-Wtype-limits")
  add_compile_options("-Wcast-qual")
  add_compile_options("-Wwrite-strings")
  add_compile_options("-Wclobbered")
  add_compile_options("-Wconversion")
  add_compile_options("-Wenum-compare")
  add_compile_options("-Wsign-compare")
  add_compile_options("-Wsign-conversion")
  add_compile_options("-Waddress")
  add_compile_options("-Wlogical-op")
  add_compile_options("-Wno-aggressive-loop-optimizations")
  add_compile_options("-Wattributes")
  add_compile_options("-Wbuiltin-macro-redefined")
  add_compile_options("-Wmissing-declarations")
  add_compile_options("-Wmissing-field-initializers")
  add_compile_options("-Wdeprecated")
  add_compile_options("-Wdeprecated-declarations")
  add_compile_options("-Woverflow")
  add_compile_options("-Wpacked")
  add_compile_options("-Wno-packed-bitfield-compat")
  add_compile_options("-Winline")
  add_compile_options("-Wint-to-pointer-cast")
  add_compile_options("-Winvalid-pch")
  add_compile_options("-Wno-long-long")
  add_compile_options("-Wno-variadic-macros")
  add_compile_options("-Wvarargs")
  add_compile_options("-Wvector-operation-performance")
  add_compile_options("-Wvla")
  add_compile_options("-Wvolatile-register-var")
  add_compile_options("-Wdisabled-optimization")
  add_compile_options("-Wstack-protector")
  add_compile_options("-Woverlength-strings")
  add_compile_options("-fvisibility=hidden")
  add_compile_options("-Wc++11-compat")
  add_compile_options("-Wconversion-null")
  add_compile_options("-Wuseless-cast")
  add_compile_options("-Winherited-variadic-ctor")
  add_compile_options("-Winvalid-offsetof")
  add_compile_options("-Wvirtual-move-assign")
  add_compile_options("-pedantic")
  add_compile_options("-fno-gnu-keywords")
  add_compile_options("-foptional-diags")
  add_compile_options("-Wctor-dtor-privacy")
  add_compile_options("-Wdelete-non-virtual-dtor")
  add_compile_options("-Wliteral-suffix")
  add_compile_options("-Wnarrowing")
  add_compile_options("-Wnon-virtual-dtor")
  add_compile_options("-Wreorder")
  add_compile_options("-Weffc++")
  add_compile_options("-fno-ext-numeric-literals")
  add_compile_options("-Wnon-template-friend")
  add_compile_options("-Wold-style-cast")
  add_compile_options("-Wpmf-conversions")
  add_compile_options("-Wsign-promo")
  add_compile_options("-Wchar-subscripts")
  add_compile_options("-Wno-ignored-qualifiers")
  add_compile_options("-Wmaybe-uninitialized")
  add_compile_options("-Wdiv-by-zero")
  add_compile_options("-Wtrampolines")
  add_compile_options("-Wfloat-equal")
  add_compile_options("-Wcast-align")
  add_compile_options("-Wempty-body")
  add_compile_options("-Wsizeof-pointer-memaccess")
  add_compile_options("-Wmultichar")
  add_compile_options("-Wnormalized=nfc")
  add_compile_options("-Wnoexcept")
  add_compile_options("-Wstrict-null-sentinel")

  # Add the basic compiler options for debug version
  set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -ggdb3")
  # Add the basic compiler options for release version
  set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -ansi -march=native -funroll-loops -O3 -DNDEBUG")

else ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
	message(FATAL_ERROR "Only the compiler gcc and clang are supported")
endif()


# Include libraries from include directory
# ------------------------------------------------------------------------------

# Common library
set(COMMON_SOURCES include/common/common.hpp)
add_library(common OBJECT ${COMMON_SOURCES})
target_link_libraries(common)
target_include_directories(common PUBLIC include/common)

# Strdup library  
set(STRDUP_SOURCES include/common/strdup.hpp)
add_library(strdup OBJECT ${STRDUP_SOURCES})
target_link_libraries(strdup)

# PFP library
set(PFP_SOURCES include/pfp/dictionary.hpp
                include/pfp/parse.hpp
                include/pfp/wt.hpp
                include/pfp/lce_support.hpp
                include/pfp/sa_support.hpp
                include/pfp/pfp.hpp 
                include/pfp/PPS_support.hpp)

add_library(pfp OBJECT ${PFP_SOURCES})
target_link_libraries(pfp common sdsl divsufsort divsufsort64 malloc_count)
target_include_directories(pfp PUBLIC include/pfp)

# PFP CST library
add_library(pfp_cst OBJECT include/pfp/pfp_cst.hpp)
target_link_libraries(pfp_cst pfp common gsacak malloc_count)
target_include_directories(pfp_cst PUBLIC include/pfp)

# Executables from src directory
# ------------------------------------------------------------------------------

# LZ77 test executables
add_executable(lz_77 src/lz_77_build.cpp)
target_link_libraries(lz_77 pfp_cst pfp common gsacak malloc_count)

add_executable(lz_77_64 src/lz_77_build.cpp)
target_link_libraries(lz_77_64 pfp_cst pfp common gsacak64 malloc_count)
target_compile_options(lz_77_64 PUBLIC -DM64)

# PFP-CST build executables
add_executable(pfp-cst_build src/pfp-cst_build.cpp)
target_link_libraries(pfp-cst_build common strdup pfp gsacak sdsl malloc_count)

add_executable(pfp-cst_build64 src/pfp-cst_build.cpp)
target_link_libraries(pfp-cst_build64 common strdup pfp gsacak64 sdsl malloc_count)
target_compile_options(pfp-cst_build64 PUBLIC -DM64)

# Configure pipeline for build folder
set(USE_INSTALL_PATH False)
set(PFP_CST_VERSION False)
#configure_file(${PROJECT_SOURCE_DIR}/pipeline/pfp-cst.in ${PROJECT_BINARY_DIR}/pfp-cst @ONLY)

# Configure pipeline for install folder
set(USE_INSTALL_PATH True)
set(PFP_CST_VERSION "0.1.0")

install(TARGETS pfp-cst_build pfp-cst_build64 TYPE RUNTIME)
install(PROGRAMS ${PROJECT_BINARY_DIR}/pfp-cst.install RENAME pfp-cst TYPE BIN)

# # Installin the library https://dominikberner.ch/cmake-interface-lib/
# install(TARGETS pfp_cst pfp common gsacak malloc_count
#         EXPORT ${PROJECT_NAME}_Targets
#         ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
#         LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
#         RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

# include(CMakePackageConfigHelpers)
# write_basic_package_version_file("pfp-cstConfigVersion.cmake"
#                                  VERSION ${VERSION}
#                                  COMPATIBILITY SameMajorVersion)

# install(EXPORT ${PROJECT_NAME}_Targets
#         FILE ${PROJECT_NAME}Targets.cmake
#         DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/${PROJECT_NAME}/cmake)

# install(FILES "${PROJECT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
#               "${PROJECT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
#         DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/${PROJECT_NAME}/cmake)

# install(DIRECTORY ${PROJECT_SOURCE_DIR}/include/pfp 
#                   ${PROJECT_SOURCE_DIR}/include/common 
#                   DESTINATION include)
# Configure cpack variables
# ------------------------------------------------------------------------------

set(CPACK_PACKAGE_VERSION_MAJOR ${VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${VERSION_PATCH})
set(CPACK_PACKAGE_VERSION "${VERSION}")

include(InstallRequiredSystemLibraries)
set(CPACK_GENERATOR "STGZ;TGZ;DEB")
set(CPACK_SOURCE_GENERATOR "TGZ")
set(CPACK_PACKAGE_VENDOR "University of Florida")
set(CPACK_PACKAGE_CONTACT "rossi.m@ufl.edu")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "PFP-CST")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/README.md")
set(CPACK_PACKAGE_NAME "${CMAKE_PROJECT_NAME}")
set(CPACK_SOURCE_PACKAGE_FILE_NAME "${CMAKE_PROJECT_NAME}-sources")

set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Massimiliano Rossi")
set(CPACK_DEBIAN_FILE_NAME DEB-DEFAULT) 
set(CPACK_COMPONENTS_GROUPING ALL_COMPONENTS_IN_ONE) # Groupp all components
set (CPACK_DEBIAN_PACKAGE_SHLIBDEPS ON)
set(CPACK_DEB_COMPONENT_INSTALL YES)
include(CPack)
