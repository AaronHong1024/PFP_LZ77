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

# Utility rule file for bit-vector-test_int-vec.2048.1.r.5432.

# Include any custom commands dependencies for this target.
include _deps/sdsl-build/test/CMakeFiles/bit-vector-test_int-vec.2048.1.r.5432.dir/compiler_depend.make

# Include the progress variables for this target.
include _deps/sdsl-build/test/CMakeFiles/bit-vector-test_int-vec.2048.1.r.5432.dir/progress.make

_deps/sdsl-build/test/CMakeFiles/bit-vector-test_int-vec.2048.1.r.5432: _deps/sdsl-src/test/test_cases/int-vec.2048.1.r.5432
_deps/sdsl-build/test/CMakeFiles/bit-vector-test_int-vec.2048.1.r.5432: _deps/sdsl-src/test/tmp
_deps/sdsl-build/test/CMakeFiles/bit-vector-test_int-vec.2048.1.r.5432: _deps/sdsl-build/test/bit_vector_test
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Execute bit-vector-test on int-vec.2048.1.r.5432."
	/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-build/test/bit_vector_test /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-src/test/test_cases/int-vec.2048.1.r.5432 /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-src/test/tmp/bit_vector_test_int-vec.2048.1.r.5432 /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-src/test/tmp

_deps/sdsl-src/test/test_cases/int-vec.2048.1.r.5432: _deps/sdsl-build/test/int_vector_generator
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating test case int-vec.2048.1.r.5432."
	/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-build/test/int_vector_generator /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-src/test/test_cases/int-vec.2048.1.r.5432 2048 1 r 5432

bit-vector-test_int-vec.2048.1.r.5432: _deps/sdsl-build/test/CMakeFiles/bit-vector-test_int-vec.2048.1.r.5432
bit-vector-test_int-vec.2048.1.r.5432: _deps/sdsl-src/test/test_cases/int-vec.2048.1.r.5432
bit-vector-test_int-vec.2048.1.r.5432: _deps/sdsl-build/test/CMakeFiles/bit-vector-test_int-vec.2048.1.r.5432.dir/build.make
.PHONY : bit-vector-test_int-vec.2048.1.r.5432

# Rule to build all files generated by this target.
_deps/sdsl-build/test/CMakeFiles/bit-vector-test_int-vec.2048.1.r.5432.dir/build: bit-vector-test_int-vec.2048.1.r.5432
.PHONY : _deps/sdsl-build/test/CMakeFiles/bit-vector-test_int-vec.2048.1.r.5432.dir/build

_deps/sdsl-build/test/CMakeFiles/bit-vector-test_int-vec.2048.1.r.5432.dir/clean:
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-build/test && $(CMAKE_COMMAND) -P CMakeFiles/bit-vector-test_int-vec.2048.1.r.5432.dir/cmake_clean.cmake
.PHONY : _deps/sdsl-build/test/CMakeFiles/bit-vector-test_int-vec.2048.1.r.5432.dir/clean

_deps/sdsl-build/test/CMakeFiles/bit-vector-test_int-vec.2048.1.r.5432.dir/depend:
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/yuhong/CLionProjects/PFP_LZ77-master /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-src/test /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-build/test /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/sdsl-build/test/CMakeFiles/bit-vector-test_int-vec.2048.1.r.5432.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : _deps/sdsl-build/test/CMakeFiles/bit-vector-test_int-vec.2048.1.r.5432.dir/depend

