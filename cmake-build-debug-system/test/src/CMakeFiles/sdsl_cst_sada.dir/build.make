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
include test/src/CMakeFiles/sdsl_cst_sada.dir/depend.make
# Include the progress variables for this target.
include test/src/CMakeFiles/sdsl_cst_sada.dir/progress.make

# Include the compile flags for this target's objects.
include test/src/CMakeFiles/sdsl_cst_sada.dir/flags.make

test/src/CMakeFiles/sdsl_cst_sada.dir/sdsl_cst_sada.cpp.o: test/src/CMakeFiles/sdsl_cst_sada.dir/flags.make
test/src/CMakeFiles/sdsl_cst_sada.dir/sdsl_cst_sada.cpp.o: ../test/src/sdsl_cst_sada.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object test/src/CMakeFiles/sdsl_cst_sada.dir/sdsl_cst_sada.cpp.o"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src && /opt/homebrew/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/sdsl_cst_sada.dir/sdsl_cst_sada.cpp.o -c /Users/yuhong/CLionProjects/PFP_LZ77-master/test/src/sdsl_cst_sada.cpp

test/src/CMakeFiles/sdsl_cst_sada.dir/sdsl_cst_sada.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/sdsl_cst_sada.dir/sdsl_cst_sada.cpp.i"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src && /opt/homebrew/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/yuhong/CLionProjects/PFP_LZ77-master/test/src/sdsl_cst_sada.cpp > CMakeFiles/sdsl_cst_sada.dir/sdsl_cst_sada.cpp.i

test/src/CMakeFiles/sdsl_cst_sada.dir/sdsl_cst_sada.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/sdsl_cst_sada.dir/sdsl_cst_sada.cpp.s"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src && /opt/homebrew/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/yuhong/CLionProjects/PFP_LZ77-master/test/src/sdsl_cst_sada.cpp -o CMakeFiles/sdsl_cst_sada.dir/sdsl_cst_sada.cpp.s

# Object files for target sdsl_cst_sada
sdsl_cst_sada_OBJECTS = \
"CMakeFiles/sdsl_cst_sada.dir/sdsl_cst_sada.cpp.o"

# External object files for target sdsl_cst_sada
sdsl_cst_sada_EXTERNAL_OBJECTS = \
"/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/thirdparty/CMakeFiles/malloc_count.dir/__/_deps/bigbwt-src/malloc_count.c.o"

test/src/sdsl_cst_sada: test/src/CMakeFiles/sdsl_cst_sada.dir/sdsl_cst_sada.cpp.o
test/src/sdsl_cst_sada: thirdparty/CMakeFiles/malloc_count.dir/__/_deps/bigbwt-src/malloc_count.c.o
test/src/sdsl_cst_sada: test/src/CMakeFiles/sdsl_cst_sada.dir/build.make
test/src/sdsl_cst_sada: _deps/sdsl-build/lib/libsdsl.a
test/src/sdsl_cst_sada: _deps/divsufsort-build/lib/libdivsufsort.a
test/src/sdsl_cst_sada: _deps/divsufsort-build/lib/libdivsufsort64.a
test/src/sdsl_cst_sada: test/src/CMakeFiles/sdsl_cst_sada.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable sdsl_cst_sada"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/sdsl_cst_sada.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
test/src/CMakeFiles/sdsl_cst_sada.dir/build: test/src/sdsl_cst_sada
.PHONY : test/src/CMakeFiles/sdsl_cst_sada.dir/build

test/src/CMakeFiles/sdsl_cst_sada.dir/clean:
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src && $(CMAKE_COMMAND) -P CMakeFiles/sdsl_cst_sada.dir/cmake_clean.cmake
.PHONY : test/src/CMakeFiles/sdsl_cst_sada.dir/clean

test/src/CMakeFiles/sdsl_cst_sada.dir/depend:
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/yuhong/CLionProjects/PFP_LZ77-master /Users/yuhong/CLionProjects/PFP_LZ77-master/test/src /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/test/src/CMakeFiles/sdsl_cst_sada.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : test/src/CMakeFiles/sdsl_cst_sada.dir/depend

