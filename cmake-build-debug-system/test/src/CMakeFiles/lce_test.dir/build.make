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
include test/src/CMakeFiles/lce_test.dir/depend.make
# Include the progress variables for this target.
include test/src/CMakeFiles/lce_test.dir/progress.make

# Include the compile flags for this target's objects.
include test/src/CMakeFiles/lce_test.dir/flags.make

test/src/CMakeFiles/lce_test.dir/lce_test.cpp.o: test/src/CMakeFiles/lce_test.dir/flags.make
test/src/CMakeFiles/lce_test.dir/lce_test.cpp.o: ../test/src/lce_test.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object test/src/CMakeFiles/lce_test.dir/lce_test.cpp.o"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src && /opt/homebrew/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/lce_test.dir/lce_test.cpp.o -c /Users/yuhong/CLionProjects/PFP_LZ77-master/test/src/lce_test.cpp

test/src/CMakeFiles/lce_test.dir/lce_test.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/lce_test.dir/lce_test.cpp.i"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src && /opt/homebrew/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/yuhong/CLionProjects/PFP_LZ77-master/test/src/lce_test.cpp > CMakeFiles/lce_test.dir/lce_test.cpp.i

test/src/CMakeFiles/lce_test.dir/lce_test.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/lce_test.dir/lce_test.cpp.s"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src && /opt/homebrew/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/yuhong/CLionProjects/PFP_LZ77-master/test/src/lce_test.cpp -o CMakeFiles/lce_test.dir/lce_test.cpp.s

# Object files for target lce_test
lce_test_OBJECTS = \
"CMakeFiles/lce_test.dir/lce_test.cpp.o"

# External object files for target lce_test
lce_test_EXTERNAL_OBJECTS = \
"/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/thirdparty/CMakeFiles/gsacak.dir/__/_deps/gsacak-src/gsacak.c.o" \
"/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/thirdparty/CMakeFiles/malloc_count.dir/__/_deps/bigbwt-src/malloc_count.c.o"

test/src/lce_test: test/src/CMakeFiles/lce_test.dir/lce_test.cpp.o
test/src/lce_test: thirdparty/CMakeFiles/gsacak.dir/__/_deps/gsacak-src/gsacak.c.o
test/src/lce_test: thirdparty/CMakeFiles/malloc_count.dir/__/_deps/bigbwt-src/malloc_count.c.o
test/src/lce_test: test/src/CMakeFiles/lce_test.dir/build.make
test/src/lce_test: _deps/sdsl-build/lib/libsdsl.a
test/src/lce_test: _deps/divsufsort-build/lib/libdivsufsort.a
test/src/lce_test: _deps/divsufsort-build/lib/libdivsufsort64.a
test/src/lce_test: _deps/sdsl-build/external/googletest/googletest/libgtest_main.a
test/src/lce_test: _deps/sdsl-build/external/googletest/googletest/libgtest.a
test/src/lce_test: test/src/CMakeFiles/lce_test.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable lce_test"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/lce_test.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
test/src/CMakeFiles/lce_test.dir/build: test/src/lce_test
.PHONY : test/src/CMakeFiles/lce_test.dir/build

test/src/CMakeFiles/lce_test.dir/clean:
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src && $(CMAKE_COMMAND) -P CMakeFiles/lce_test.dir/cmake_clean.cmake
.PHONY : test/src/CMakeFiles/lce_test.dir/clean

test/src/CMakeFiles/lce_test.dir/depend:
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/yuhong/CLionProjects/PFP_LZ77-master /Users/yuhong/CLionProjects/PFP_LZ77-master/test/src /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src/CMakeFiles/lce_test.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : test/src/CMakeFiles/lce_test.dir/depend

