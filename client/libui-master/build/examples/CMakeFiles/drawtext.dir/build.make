# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.5.2/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.5.2/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/giovannidispoto/desktop/libui-master

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/giovannidispoto/desktop/libui-master/build

# Include any dependencies generated for this target.
include examples/CMakeFiles/drawtext.dir/depend.make

# Include the progress variables for this target.
include examples/CMakeFiles/drawtext.dir/progress.make

# Include the compile flags for this target's objects.
include examples/CMakeFiles/drawtext.dir/flags.make

examples/CMakeFiles/drawtext.dir/drawtext/main.c.o: examples/CMakeFiles/drawtext.dir/flags.make
examples/CMakeFiles/drawtext.dir/drawtext/main.c.o: ../examples/drawtext/main.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/giovannidispoto/desktop/libui-master/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object examples/CMakeFiles/drawtext.dir/drawtext/main.c.o"
	cd /Users/giovannidispoto/desktop/libui-master/build/examples && /Library/Developer/CommandLineTools/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/drawtext.dir/drawtext/main.c.o   -c /Users/giovannidispoto/desktop/libui-master/examples/drawtext/main.c

examples/CMakeFiles/drawtext.dir/drawtext/main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/drawtext.dir/drawtext/main.c.i"
	cd /Users/giovannidispoto/desktop/libui-master/build/examples && /Library/Developer/CommandLineTools/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/giovannidispoto/desktop/libui-master/examples/drawtext/main.c > CMakeFiles/drawtext.dir/drawtext/main.c.i

examples/CMakeFiles/drawtext.dir/drawtext/main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/drawtext.dir/drawtext/main.c.s"
	cd /Users/giovannidispoto/desktop/libui-master/build/examples && /Library/Developer/CommandLineTools/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/giovannidispoto/desktop/libui-master/examples/drawtext/main.c -o CMakeFiles/drawtext.dir/drawtext/main.c.s

examples/CMakeFiles/drawtext.dir/drawtext/main.c.o.requires:

.PHONY : examples/CMakeFiles/drawtext.dir/drawtext/main.c.o.requires

examples/CMakeFiles/drawtext.dir/drawtext/main.c.o.provides: examples/CMakeFiles/drawtext.dir/drawtext/main.c.o.requires
	$(MAKE) -f examples/CMakeFiles/drawtext.dir/build.make examples/CMakeFiles/drawtext.dir/drawtext/main.c.o.provides.build
.PHONY : examples/CMakeFiles/drawtext.dir/drawtext/main.c.o.provides

examples/CMakeFiles/drawtext.dir/drawtext/main.c.o.provides.build: examples/CMakeFiles/drawtext.dir/drawtext/main.c.o


# Object files for target drawtext
drawtext_OBJECTS = \
"CMakeFiles/drawtext.dir/drawtext/main.c.o"

# External object files for target drawtext
drawtext_EXTERNAL_OBJECTS =

out/drawtext: examples/CMakeFiles/drawtext.dir/drawtext/main.c.o
out/drawtext: examples/CMakeFiles/drawtext.dir/build.make
out/drawtext: out/libui.A.dylib
out/drawtext: examples/CMakeFiles/drawtext.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/giovannidispoto/desktop/libui-master/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable ../out/drawtext"
	cd /Users/giovannidispoto/desktop/libui-master/build/examples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/drawtext.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/CMakeFiles/drawtext.dir/build: out/drawtext

.PHONY : examples/CMakeFiles/drawtext.dir/build

examples/CMakeFiles/drawtext.dir/requires: examples/CMakeFiles/drawtext.dir/drawtext/main.c.o.requires

.PHONY : examples/CMakeFiles/drawtext.dir/requires

examples/CMakeFiles/drawtext.dir/clean:
	cd /Users/giovannidispoto/desktop/libui-master/build/examples && $(CMAKE_COMMAND) -P CMakeFiles/drawtext.dir/cmake_clean.cmake
.PHONY : examples/CMakeFiles/drawtext.dir/clean

examples/CMakeFiles/drawtext.dir/depend:
	cd /Users/giovannidispoto/desktop/libui-master/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/giovannidispoto/desktop/libui-master /Users/giovannidispoto/desktop/libui-master/examples /Users/giovannidispoto/desktop/libui-master/build /Users/giovannidispoto/desktop/libui-master/build/examples /Users/giovannidispoto/desktop/libui-master/build/examples/CMakeFiles/drawtext.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : examples/CMakeFiles/drawtext.dir/depend
