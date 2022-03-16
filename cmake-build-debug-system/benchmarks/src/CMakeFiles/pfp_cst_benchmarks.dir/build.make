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
include benchmarks/src/CMakeFiles/pfp_cst_benchmarks.dir/depend.make
# Include the progress variables for this target.
include benchmarks/src/CMakeFiles/pfp_cst_benchmarks.dir/progress.make

# Include the compile flags for this target's objects.
include benchmarks/src/CMakeFiles/pfp_cst_benchmarks.dir/flags.make

benchmarks/src/CMakeFiles/pfp_cst_benchmarks.dir/pfp_cst_benchmarks.cpp.o: benchmarks/src/CMakeFiles/pfp_cst_benchmarks.dir/flags.make
benchmarks/src/CMakeFiles/pfp_cst_benchmarks.dir/pfp_cst_benchmarks.cpp.o: ../benchmarks/src/pfp_cst_benchmarks.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object benchmarks/src/CMakeFiles/pfp_cst_benchmarks.dir/pfp_cst_benchmarks.cpp.o"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/benchmarks/src && /opt/homebrew/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/pfp_cst_benchmarks.dir/pfp_cst_benchmarks.cpp.o -c /Users/yuhong/CLionProjects/PFP_LZ77-master/benchmarks/src/pfp_cst_benchmarks.cpp

benchmarks/src/CMakeFiles/pfp_cst_benchmarks.dir/pfp_cst_benchmarks.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/pfp_cst_benchmarks.dir/pfp_cst_benchmarks.cpp.i"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/benchmarks/src && /opt/homebrew/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/yuhong/CLionProjects/PFP_LZ77-master/benchmarks/src/pfp_cst_benchmarks.cpp > CMakeFiles/pfp_cst_benchmarks.dir/pfp_cst_benchmarks.cpp.i

benchmarks/src/CMakeFiles/pfp_cst_benchmarks.dir/pfp_cst_benchmarks.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/pfp_cst_benchmarks.dir/pfp_cst_benchmarks.cpp.s"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/benchmarks/src && /opt/homebrew/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/yuhong/CLionProjects/PFP_LZ77-master/benchmarks/src/pfp_cst_benchmarks.cpp -o CMakeFiles/pfp_cst_benchmarks.dir/pfp_cst_benchmarks.cpp.s

# Object files for target pfp_cst_benchmarks
pfp_cst_benchmarks_OBJECTS = \
"CMakeFiles/pfp_cst_benchmarks.dir/pfp_cst_benchmarks.cpp.o"

# External object files for target pfp_cst_benchmarks
pfp_cst_benchmarks_EXTERNAL_OBJECTS = \
"/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/thirdparty/CMakeFiles/gsacak.dir/__/_deps/gsacak-src/gsacak.c.o" \
"/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/thirdparty/CMakeFiles/malloc_count.dir/__/_deps/bigbwt-src/malloc_count.c.o"

benchmarks/src/pfp_cst_benchmarks: benchmarks/src/CMakeFiles/pfp_cst_benchmarks.dir/pfp_cst_benchmarks.cpp.o
benchmarks/src/pfp_cst_benchmarks: thirdparty/CMakeFiles/gsacak.dir/__/_deps/gsacak-src/gsacak.c.o
benchmarks/src/pfp_cst_benchmarks: thirdparty/CMakeFiles/malloc_count.dir/__/_deps/bigbwt-src/malloc_count.c.o
benchmarks/src/pfp_cst_benchmarks: benchmarks/src/CMakeFiles/pfp_cst_benchmarks.dir/build.make
benchmarks/src/pfp_cst_benchmarks: _deps/sdsl-build/lib/libsdsl.a
benchmarks/src/pfp_cst_benchmarks: _deps/divsufsort-build/lib/libdivsufsort.a
benchmarks/src/pfp_cst_benchmarks: _deps/divsufsort-build/lib/libdivsufsort64.a
benchmarks/src/pfp_cst_benchmarks: _deps/benchmark-build/src/libbenchmark.a
benchmarks/src/pfp_cst_benchmarks: benchmarks/src/CMakeFiles/pfp_cst_benchmarks.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable pfp_cst_benchmarks"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/benchmarks/src && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/pfp_cst_benchmarks.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
benchmarks/src/CMakeFiles/pfp_cst_benchmarks.dir/build: benchmarks/src/pfp_cst_benchmarks
.PHONY : benchmarks/src/CMakeFiles/pfp_cst_benchmarks.dir/build

benchmarks/src/CMakeFiles/pfp_cst_benchmarks.dir/clean:
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/benchmarks/src && $(CMAKE_COMMAND) -P CMakeFiles/pfp_cst_benchmarks.dir/cmake_clean.cmake
.PHONY : benchmarks/src/CMakeFiles/pfp_cst_benchmarks.dir/clean

benchmarks/src/CMakeFiles/pfp_cst_benchmarks.dir/depend:
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/yuhong/CLionProjects/PFP_LZ77-master /Users/yuhong/CLionProjects/PFP_LZ77-master/benchmarks/src /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/benchmarks/src /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/benchmarks/src/CMakeFiles/pfp_cst_benchmarks.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : benchmarks/src/CMakeFiles/pfp_cst_benchmarks.dir/depend

