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
include thirdparty/CMakeFiles/gsacak64.dir/depend.make
# Include the progress variables for this target.
include thirdparty/CMakeFiles/gsacak64.dir/progress.make

# Include the compile flags for this target's objects.
include thirdparty/CMakeFiles/gsacak64.dir/flags.make

thirdparty/CMakeFiles/gsacak64.dir/__/_deps/gsacak-src/gsacak.c.o: thirdparty/CMakeFiles/gsacak64.dir/flags.make
thirdparty/CMakeFiles/gsacak64.dir/__/_deps/gsacak-src/gsacak.c.o: _deps/gsacak-src/gsacak.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object thirdparty/CMakeFiles/gsacak64.dir/__/_deps/gsacak-src/gsacak.c.o"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/thirdparty && /opt/homebrew/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/gsacak64.dir/__/_deps/gsacak-src/gsacak.c.o -c /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/gsacak-src/gsacak.c

thirdparty/CMakeFiles/gsacak64.dir/__/_deps/gsacak-src/gsacak.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/gsacak64.dir/__/_deps/gsacak-src/gsacak.c.i"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/thirdparty && /opt/homebrew/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/gsacak-src/gsacak.c > CMakeFiles/gsacak64.dir/__/_deps/gsacak-src/gsacak.c.i

thirdparty/CMakeFiles/gsacak64.dir/__/_deps/gsacak-src/gsacak.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/gsacak64.dir/__/_deps/gsacak-src/gsacak.c.s"
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/thirdparty && /opt/homebrew/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/_deps/gsacak-src/gsacak.c -o CMakeFiles/gsacak64.dir/__/_deps/gsacak-src/gsacak.c.s

gsacak64: thirdparty/CMakeFiles/gsacak64.dir/__/_deps/gsacak-src/gsacak.c.o
gsacak64: thirdparty/CMakeFiles/gsacak64.dir/build.make
.PHONY : gsacak64

# Rule to build all files generated by this target.
thirdparty/CMakeFiles/gsacak64.dir/build: gsacak64
.PHONY : thirdparty/CMakeFiles/gsacak64.dir/build

thirdparty/CMakeFiles/gsacak64.dir/clean:
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/thirdparty && $(CMAKE_COMMAND) -P CMakeFiles/gsacak64.dir/cmake_clean.cmake
.PHONY : thirdparty/CMakeFiles/gsacak64.dir/clean

thirdparty/CMakeFiles/gsacak64.dir/depend:
	cd /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/yuhong/CLionProjects/PFP_LZ77-master /Users/yuhong/CLionProjects/PFP_LZ77-master/thirdparty /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/thirdparty /Users/yuhong/CLionProjects/PFP_LZ77-master/cmake-build-debug-system/thirdparty/CMakeFiles/gsacak64.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : thirdparty/CMakeFiles/gsacak64.dir/depend

