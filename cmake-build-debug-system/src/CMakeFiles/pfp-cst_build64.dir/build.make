# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.20

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake

# The command to remove a file.
RM = /Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/yuhong/CLionProjects/PFP_LZ77-master

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system

# Include any dependencies generated for this target.
include src/CMakeFiles/pfp-cst_build64.dir/depend.make
# Include the progress variables for this target.
include src/CMakeFiles/pfp-cst_build64.dir/progress.make

# Include the compile flags for this target's objects.
include src/CMakeFiles/pfp-cst_build64.dir/flags.make

src/CMakeFiles/pfp-cst_build64.dir/pfp-cst_build.cpp.o: src/CMakeFiles/pfp-cst_build64.dir/flags.make
src/CMakeFiles/pfp-cst_build64.dir/pfp-cst_build.cpp.o: ../src/pfp-cst_build.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object src/CMakeFiles/pfp-cst_build64.dir/pfp-cst_build.cpp.o"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/src && /opt/homebrew/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/pfp-cst_build64.dir/pfp-cst_build.cpp.o -c /Users/yuhong/CLionProjects/PFP_LZ77-master/src/pfp-cst_build.cpp

src/CMakeFiles/pfp-cst_build64.dir/pfp-cst_build.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/pfp-cst_build64.dir/pfp-cst_build.cpp.i"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/src && /opt/homebrew/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/yuhong/CLionProjects/PFP_LZ77-master/src/pfp-cst_build.cpp > CMakeFiles/pfp-cst_build64.dir/pfp-cst_build.cpp.i

src/CMakeFiles/pfp-cst_build64.dir/pfp-cst_build.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/pfp-cst_build64.dir/pfp-cst_build.cpp.s"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/src && /opt/homebrew/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/yuhong/CLionProjects/PFP_LZ77-master/src/pfp-cst_build.cpp -o CMakeFiles/pfp-cst_build64.dir/pfp-cst_build.cpp.s

# Object files for target pfp-cst_build64
pfp__cst_build64_OBJECTS = \
"CMakeFiles/pfp-cst_build64.dir/pfp-cst_build.cpp.o"

# External object files for target pfp-cst_build64
pfp__cst_build64_EXTERNAL_OBJECTS = \
"/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/thirdparty/CMakeFiles/gsacak64.dir/__/_deps/gsacak-src/gsacak.c.o" \
"/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/thirdparty/CMakeFiles/malloc_count.dir/__/_deps/bigbwt-src/malloc_count.c.o"

src/pfp-cst_build64: src/CMakeFiles/pfp-cst_build64.dir/pfp-cst_build.cpp.o
src/pfp-cst_build64: thirdparty/CMakeFiles/gsacak64.dir/__/_deps/gsacak-src/gsacak.c.o
src/pfp-cst_build64: thirdparty/CMakeFiles/malloc_count.dir/__/_deps/bigbwt-src/malloc_count.c.o
src/pfp-cst_build64: src/CMakeFiles/pfp-cst_build64.dir/build.make
src/pfp-cst_build64: _deps/sdsl-build/lib/libsdsl.a
src/pfp-cst_build64: _deps/divsufsort-build/lib/libdivsufsort.a
src/pfp-cst_build64: _deps/divsufsort-build/lib/libdivsufsort64.a
src/pfp-cst_build64: src/CMakeFiles/pfp-cst_build64.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable pfp-cst_build64"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/src && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/pfp-cst_build64.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/CMakeFiles/pfp-cst_build64.dir/build: src/pfp-cst_build64
.PHONY : src/CMakeFiles/pfp-cst_build64.dir/build

src/CMakeFiles/pfp-cst_build64.dir/clean:
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/src && $(CMAKE_COMMAND) -P CMakeFiles/pfp-cst_build64.dir/cmake_clean.cmake
.PHONY : src/CMakeFiles/pfp-cst_build64.dir/clean

src/CMakeFiles/pfp-cst_build64.dir/depend:
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/yuhong/CLionProjects/PFP_LZ77-master /Users/yuhong/CLionProjects/PFP_LZ77-master/src /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/src /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/src/CMakeFiles/pfp-cst_build64.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/CMakeFiles/pfp-cst_build64.dir/depend

