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
include test/src/CMakeFiles/lce_benchmark.dir/depend.make
# Include the progress variables for this target.
include test/src/CMakeFiles/lce_benchmark.dir/progress.make

# Include the compile flags for this target's objects.
include test/src/CMakeFiles/lce_benchmark.dir/flags.make

test/src/CMakeFiles/lce_benchmark.dir/lce_benchmark.cpp.o: test/src/CMakeFiles/lce_benchmark.dir/flags.make
test/src/CMakeFiles/lce_benchmark.dir/lce_benchmark.cpp.o: ../test/src/lce_benchmark.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object test/src/CMakeFiles/lce_benchmark.dir/lce_benchmark.cpp.o"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src && /opt/homebrew/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/lce_benchmark.dir/lce_benchmark.cpp.o -c /Users/yuhong/CLionProjects/PFP_LZ77-master/test/src/lce_benchmark.cpp

test/src/CMakeFiles/lce_benchmark.dir/lce_benchmark.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/lce_benchmark.dir/lce_benchmark.cpp.i"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src && /opt/homebrew/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/yuhong/CLionProjects/PFP_LZ77-master/test/src/lce_benchmark.cpp > CMakeFiles/lce_benchmark.dir/lce_benchmark.cpp.i

test/src/CMakeFiles/lce_benchmark.dir/lce_benchmark.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/lce_benchmark.dir/lce_benchmark.cpp.s"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src && /opt/homebrew/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/yuhong/CLionProjects/PFP_LZ77-master/test/src/lce_benchmark.cpp -o CMakeFiles/lce_benchmark.dir/lce_benchmark.cpp.s

# Object files for target lce_benchmark
lce_benchmark_OBJECTS = \
"CMakeFiles/lce_benchmark.dir/lce_benchmark.cpp.o"

# External object files for target lce_benchmark
lce_benchmark_EXTERNAL_OBJECTS = \
"/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/thirdparty/CMakeFiles/gsacak.dir/__/_deps/gsacak-src/gsacak.c.o" \
"/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/thirdparty/CMakeFiles/malloc_count.dir/__/_deps/bigbwt-src/malloc_count.c.o"

test/src/lce_benchmark: test/src/CMakeFiles/lce_benchmark.dir/lce_benchmark.cpp.o
test/src/lce_benchmark: thirdparty/CMakeFiles/gsacak.dir/__/_deps/gsacak-src/gsacak.c.o
test/src/lce_benchmark: thirdparty/CMakeFiles/malloc_count.dir/__/_deps/bigbwt-src/malloc_count.c.o
test/src/lce_benchmark: test/src/CMakeFiles/lce_benchmark.dir/build.make
test/src/lce_benchmark: _deps/sdsl-build/lib/libsdsl.a
test/src/lce_benchmark: _deps/divsufsort-build/lib/libdivsufsort.a
test/src/lce_benchmark: _deps/divsufsort-build/lib/libdivsufsort64.a
test/src/lce_benchmark: _deps/benchmark-build/src/libbenchmark.a
test/src/lce_benchmark: test/src/CMakeFiles/lce_benchmark.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable lce_benchmark"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/lce_benchmark.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
test/src/CMakeFiles/lce_benchmark.dir/build: test/src/lce_benchmark
.PHONY : test/src/CMakeFiles/lce_benchmark.dir/build

test/src/CMakeFiles/lce_benchmark.dir/clean:
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src && $(CMAKE_COMMAND) -P CMakeFiles/lce_benchmark.dir/cmake_clean.cmake
.PHONY : test/src/CMakeFiles/lce_benchmark.dir/clean

test/src/CMakeFiles/lce_benchmark.dir/depend:
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/yuhong/CLionProjects/PFP_LZ77-master /Users/yuhong/CLionProjects/PFP_LZ77-master/test/src /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src/CMakeFiles/lce_benchmark.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : test/src/CMakeFiles/lce_benchmark.dir/depend

