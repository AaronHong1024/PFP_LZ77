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
include _deps/sdsl-build/test/CMakeFiles/lcp_construct_test.dir/depend.make
# Include the progress variables for this target.
include _deps/sdsl-build/test/CMakeFiles/lcp_construct_test.dir/progress.make

# Include the compile flags for this target's objects.
include _deps/sdsl-build/test/CMakeFiles/lcp_construct_test.dir/flags.make

_deps/sdsl-build/test/CMakeFiles/lcp_construct_test.dir/lcp_construct_test.cpp.o: _deps/sdsl-build/test/CMakeFiles/lcp_construct_test.dir/flags.make
_deps/sdsl-build/test/CMakeFiles/lcp_construct_test.dir/lcp_construct_test.cpp.o: _deps/sdsl-src/test/lcp_construct_test.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object _deps/sdsl-build/test/CMakeFiles/lcp_construct_test.dir/lcp_construct_test.cpp.o"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-build/test && /opt/homebrew/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/lcp_construct_test.dir/lcp_construct_test.cpp.o -c /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-src/test/lcp_construct_test.cpp

_deps/sdsl-build/test/CMakeFiles/lcp_construct_test.dir/lcp_construct_test.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/lcp_construct_test.dir/lcp_construct_test.cpp.i"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-build/test && /opt/homebrew/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-src/test/lcp_construct_test.cpp > CMakeFiles/lcp_construct_test.dir/lcp_construct_test.cpp.i

_deps/sdsl-build/test/CMakeFiles/lcp_construct_test.dir/lcp_construct_test.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/lcp_construct_test.dir/lcp_construct_test.cpp.s"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-build/test && /opt/homebrew/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-src/test/lcp_construct_test.cpp -o CMakeFiles/lcp_construct_test.dir/lcp_construct_test.cpp.s

# Object files for target lcp_construct_test
lcp_construct_test_OBJECTS = \
"CMakeFiles/lcp_construct_test.dir/lcp_construct_test.cpp.o"

# External object files for target lcp_construct_test
lcp_construct_test_EXTERNAL_OBJECTS =

_deps/sdsl-build/test/lcp_construct_test: _deps/sdsl-build/test/CMakeFiles/lcp_construct_test.dir/lcp_construct_test.cpp.o
_deps/sdsl-build/test/lcp_construct_test: _deps/sdsl-build/test/CMakeFiles/lcp_construct_test.dir/build.make
_deps/sdsl-build/test/lcp_construct_test: _deps/sdsl-build/lib/libsdsl.a
_deps/sdsl-build/test/lcp_construct_test: _deps/sdsl-build/external/googletest/googletest/libgtest.a
_deps/sdsl-build/test/lcp_construct_test: _deps/divsufsort-build/lib/libdivsufsort.a
_deps/sdsl-build/test/lcp_construct_test: _deps/divsufsort-build/lib/libdivsufsort64.a
_deps/sdsl-build/test/lcp_construct_test: _deps/sdsl-build/test/CMakeFiles/lcp_construct_test.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable lcp_construct_test"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-build/test && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/lcp_construct_test.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
_deps/sdsl-build/test/CMakeFiles/lcp_construct_test.dir/build: _deps/sdsl-build/test/lcp_construct_test
.PHONY : _deps/sdsl-build/test/CMakeFiles/lcp_construct_test.dir/build

_deps/sdsl-build/test/CMakeFiles/lcp_construct_test.dir/clean:
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-build/test && $(CMAKE_COMMAND) -P CMakeFiles/lcp_construct_test.dir/cmake_clean.cmake
.PHONY : _deps/sdsl-build/test/CMakeFiles/lcp_construct_test.dir/clean

_deps/sdsl-build/test/CMakeFiles/lcp_construct_test.dir/depend:
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/yuhong/CLionProjects/PFP_LZ77-master /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-src/test /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-build/test /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-build/test/CMakeFiles/lcp_construct_test.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : _deps/sdsl-build/test/CMakeFiles/lcp_construct_test.dir/depend

