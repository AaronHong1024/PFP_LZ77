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
include test/src/CMakeFiles/ds_building_wt_wm64.dir/depend.make
# Include the progress variables for this target.
include test/src/CMakeFiles/ds_building_wt_wm64.dir/progress.make

# Include the compile flags for this target's objects.
include test/src/CMakeFiles/ds_building_wt_wm64.dir/flags.make

test/src/CMakeFiles/ds_building_wt_wm64.dir/ds_building_wt_wm.cpp.o: test/src/CMakeFiles/ds_building_wt_wm64.dir/flags.make
test/src/CMakeFiles/ds_building_wt_wm64.dir/ds_building_wt_wm.cpp.o: ../test/src/ds_building_wt_wm.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object test/src/CMakeFiles/ds_building_wt_wm64.dir/ds_building_wt_wm.cpp.o"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src && /opt/homebrew/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/ds_building_wt_wm64.dir/ds_building_wt_wm.cpp.o -c /Users/yuhong/CLionProjects/PFP_LZ77-master/test/src/ds_building_wt_wm.cpp

test/src/CMakeFiles/ds_building_wt_wm64.dir/ds_building_wt_wm.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/ds_building_wt_wm64.dir/ds_building_wt_wm.cpp.i"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src && /opt/homebrew/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/yuhong/CLionProjects/PFP_LZ77-master/test/src/ds_building_wt_wm.cpp > CMakeFiles/ds_building_wt_wm64.dir/ds_building_wt_wm.cpp.i

test/src/CMakeFiles/ds_building_wt_wm64.dir/ds_building_wt_wm.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/ds_building_wt_wm64.dir/ds_building_wt_wm.cpp.s"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src && /opt/homebrew/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/yuhong/CLionProjects/PFP_LZ77-master/test/src/ds_building_wt_wm.cpp -o CMakeFiles/ds_building_wt_wm64.dir/ds_building_wt_wm.cpp.s

# Object files for target ds_building_wt_wm64
ds_building_wt_wm64_OBJECTS = \
"CMakeFiles/ds_building_wt_wm64.dir/ds_building_wt_wm.cpp.o"

# External object files for target ds_building_wt_wm64
ds_building_wt_wm64_EXTERNAL_OBJECTS = \
"/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/thirdparty/CMakeFiles/gsacak64.dir/__/_deps/gsacak-src/gsacak.c.o" \
"/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/thirdparty/CMakeFiles/malloc_count.dir/__/_deps/bigbwt-src/malloc_count.c.o"

test/src/ds_building_wt_wm64: test/src/CMakeFiles/ds_building_wt_wm64.dir/ds_building_wt_wm.cpp.o
test/src/ds_building_wt_wm64: thirdparty/CMakeFiles/gsacak64.dir/__/_deps/gsacak-src/gsacak.c.o
test/src/ds_building_wt_wm64: thirdparty/CMakeFiles/malloc_count.dir/__/_deps/bigbwt-src/malloc_count.c.o
test/src/ds_building_wt_wm64: test/src/CMakeFiles/ds_building_wt_wm64.dir/build.make
test/src/ds_building_wt_wm64: _deps/sdsl-build/lib/libsdsl.a
test/src/ds_building_wt_wm64: _deps/divsufsort-build/lib/libdivsufsort.a
test/src/ds_building_wt_wm64: _deps/divsufsort-build/lib/libdivsufsort64.a
test/src/ds_building_wt_wm64: test/src/CMakeFiles/ds_building_wt_wm64.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ds_building_wt_wm64"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/ds_building_wt_wm64.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
test/src/CMakeFiles/ds_building_wt_wm64.dir/build: test/src/ds_building_wt_wm64
.PHONY : test/src/CMakeFiles/ds_building_wt_wm64.dir/build

test/src/CMakeFiles/ds_building_wt_wm64.dir/clean:
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src && $(CMAKE_COMMAND) -P CMakeFiles/ds_building_wt_wm64.dir/cmake_clean.cmake
.PHONY : test/src/CMakeFiles/ds_building_wt_wm64.dir/clean

test/src/CMakeFiles/ds_building_wt_wm64.dir/depend:
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/yuhong/CLionProjects/PFP_LZ77-master /Users/yuhong/CLionProjects/PFP_LZ77-master/test/src /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src/CMakeFiles/ds_building_wt_wm64.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : test/src/CMakeFiles/ds_building_wt_wm64.dir/depend

