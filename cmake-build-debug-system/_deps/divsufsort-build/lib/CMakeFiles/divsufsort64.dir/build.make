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

# Produce verbose output by default.
VERBOSE = 1

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
include _deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/depend.make
# Include the progress variables for this target.
include _deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/progress.make

# Include the compile flags for this target's objects.
include _deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/flags.make

_deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/divsufsort.o: _deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/flags.make
_deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/divsufsort.o: _deps/divsufsort-src/lib/divsufsort.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object _deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/divsufsort.o"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-build/lib && /opt/homebrew/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/divsufsort64.dir/divsufsort.o -c /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-src/lib/divsufsort.c

_deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/divsufsort.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/divsufsort64.dir/divsufsort.i"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-build/lib && /opt/homebrew/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-src/lib/divsufsort.c > CMakeFiles/divsufsort64.dir/divsufsort.i

_deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/divsufsort.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/divsufsort64.dir/divsufsort.s"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-build/lib && /opt/homebrew/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-src/lib/divsufsort.c -o CMakeFiles/divsufsort64.dir/divsufsort.s

_deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/sssort.o: _deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/flags.make
_deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/sssort.o: _deps/divsufsort-src/lib/sssort.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object _deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/sssort.o"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-build/lib && /opt/homebrew/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/divsufsort64.dir/sssort.o -c /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-src/lib/sssort.c

_deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/sssort.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/divsufsort64.dir/sssort.i"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-build/lib && /opt/homebrew/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-src/lib/sssort.c > CMakeFiles/divsufsort64.dir/sssort.i

_deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/sssort.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/divsufsort64.dir/sssort.s"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-build/lib && /opt/homebrew/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-src/lib/sssort.c -o CMakeFiles/divsufsort64.dir/sssort.s

_deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/trsort.o: _deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/flags.make
_deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/trsort.o: _deps/divsufsort-src/lib/trsort.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object _deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/trsort.o"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-build/lib && /opt/homebrew/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/divsufsort64.dir/trsort.o -c /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-src/lib/trsort.c

_deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/trsort.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/divsufsort64.dir/trsort.i"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-build/lib && /opt/homebrew/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-src/lib/trsort.c > CMakeFiles/divsufsort64.dir/trsort.i

_deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/trsort.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/divsufsort64.dir/trsort.s"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-build/lib && /opt/homebrew/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-src/lib/trsort.c -o CMakeFiles/divsufsort64.dir/trsort.s

_deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/utils.o: _deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/flags.make
_deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/utils.o: _deps/divsufsort-src/lib/utils.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object _deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/utils.o"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-build/lib && /opt/homebrew/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/divsufsort64.dir/utils.o -c /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-src/lib/utils.c

_deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/utils.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/divsufsort64.dir/utils.i"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-build/lib && /opt/homebrew/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-src/lib/utils.c > CMakeFiles/divsufsort64.dir/utils.i

_deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/utils.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/divsufsort64.dir/utils.s"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-build/lib && /opt/homebrew/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-src/lib/utils.c -o CMakeFiles/divsufsort64.dir/utils.s

# Object files for target divsufsort64
divsufsort64_OBJECTS = \
"CMakeFiles/divsufsort64.dir/divsufsort.o" \
"CMakeFiles/divsufsort64.dir/sssort.o" \
"CMakeFiles/divsufsort64.dir/trsort.o" \
"CMakeFiles/divsufsort64.dir/utils.o"

# External object files for target divsufsort64
divsufsort64_EXTERNAL_OBJECTS =

_deps/divsufsort-build/lib/libdivsufsort64.a: _deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/divsufsort.o
_deps/divsufsort-build/lib/libdivsufsort64.a: _deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/sssort.o
_deps/divsufsort-build/lib/libdivsufsort64.a: _deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/trsort.o
_deps/divsufsort-build/lib/libdivsufsort64.a: _deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/utils.o
_deps/divsufsort-build/lib/libdivsufsort64.a: _deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/build.make
_deps/divsufsort-build/lib/libdivsufsort64.a: _deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking C static library libdivsufsort64.a"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-build/lib && $(CMAKE_COMMAND) -P CMakeFiles/divsufsort64.dir/cmake_clean_target.cmake
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-build/lib && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/divsufsort64.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
_deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/build: _deps/divsufsort-build/lib/libdivsufsort64.a
.PHONY : _deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/build

_deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/clean:
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-build/lib && $(CMAKE_COMMAND) -P CMakeFiles/divsufsort64.dir/cmake_clean.cmake
.PHONY : _deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/clean

_deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/depend:
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/yuhong/CLionProjects/PFP_LZ77-master /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-src/lib /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-build/lib /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : _deps/divsufsort-build/lib/CMakeFiles/divsufsort64.dir/depend

