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
include examples/CMakeFiles/cpp-multithread.dir/depend.make

# Include the progress variables for this target.
include examples/CMakeFiles/cpp-multithread.dir/progress.make

# Include the compile flags for this target's objects.
include examples/CMakeFiles/cpp-multithread.dir/flags.make

examples/CMakeFiles/cpp-multithread.dir/cpp-multithread/main.cpp.o: examples/CMakeFiles/cpp-multithread.dir/flags.make
examples/CMakeFiles/cpp-multithread.dir/cpp-multithread/main.cpp.o: ../examples/cpp-multithread/main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/giovannidispoto/desktop/libui-master/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object examples/CMakeFiles/cpp-multithread.dir/cpp-multithread/main.cpp.o"
	cd /Users/giovannidispoto/desktop/libui-master/build/examples && /Library/Developer/CommandLineTools/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/cpp-multithread.dir/cpp-multithread/main.cpp.o -c /Users/giovannidispoto/desktop/libui-master/examples/cpp-multithread/main.cpp

examples/CMakeFiles/cpp-multithread.dir/cpp-multithread/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/cpp-multithread.dir/cpp-multithread/main.cpp.i"
	cd /Users/giovannidispoto/desktop/libui-master/build/examples && /Library/Developer/CommandLineTools/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/giovannidispoto/desktop/libui-master/examples/cpp-multithread/main.cpp > CMakeFiles/cpp-multithread.dir/cpp-multithread/main.cpp.i

examples/CMakeFiles/cpp-multithread.dir/cpp-multithread/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/cpp-multithread.dir/cpp-multithread/main.cpp.s"
	cd /Users/giovannidispoto/desktop/libui-master/build/examples && /Library/Developer/CommandLineTools/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/giovannidispoto/desktop/libui-master/examples/cpp-multithread/main.cpp -o CMakeFiles/cpp-multithread.dir/cpp-multithread/main.cpp.s

examples/CMakeFiles/cpp-multithread.dir/cpp-multithread/main.cpp.o.requires:

.PHONY : examples/CMakeFiles/cpp-multithread.dir/cpp-multithread/main.cpp.o.requires

examples/CMakeFiles/cpp-multithread.dir/cpp-multithread/main.cpp.o.provides: examples/CMakeFiles/cpp-multithread.dir/cpp-multithread/main.cpp.o.requires
	$(MAKE) -f examples/CMakeFiles/cpp-multithread.dir/build.make examples/CMakeFiles/cpp-multithread.dir/cpp-multithread/main.cpp.o.provides.build
.PHONY : examples/CMakeFiles/cpp-multithread.dir/cpp-multithread/main.cpp.o.provides

examples/CMakeFiles/cpp-multithread.dir/cpp-multithread/main.cpp.o.provides.build: examples/CMakeFiles/cpp-multithread.dir/cpp-multithread/main.cpp.o


# Object files for target cpp-multithread
cpp__multithread_OBJECTS = \
"CMakeFiles/cpp-multithread.dir/cpp-multithread/main.cpp.o"

# External object files for target cpp-multithread
cpp__multithread_EXTERNAL_OBJECTS =

out/cpp-multithread: examples/CMakeFiles/cpp-multithread.dir/cpp-multithread/main.cpp.o
out/cpp-multithread: examples/CMakeFiles/cpp-multithread.dir/build.make
out/cpp-multithread: out/libui.A.dylib
out/cpp-multithread: examples/CMakeFiles/cpp-multithread.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/giovannidispoto/desktop/libui-master/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ../out/cpp-multithread"
	cd /Users/giovannidispoto/desktop/libui-master/build/examples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/cpp-multithread.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/CMakeFiles/cpp-multithread.dir/build: out/cpp-multithread

.PHONY : examples/CMakeFiles/cpp-multithread.dir/build

examples/CMakeFiles/cpp-multithread.dir/requires: examples/CMakeFiles/cpp-multithread.dir/cpp-multithread/main.cpp.o.requires

.PHONY : examples/CMakeFiles/cpp-multithread.dir/requires

examples/CMakeFiles/cpp-multithread.dir/clean:
	cd /Users/giovannidispoto/desktop/libui-master/build/examples && $(CMAKE_COMMAND) -P CMakeFiles/cpp-multithread.dir/cmake_clean.cmake
.PHONY : examples/CMakeFiles/cpp-multithread.dir/clean

examples/CMakeFiles/cpp-multithread.dir/depend:
	cd /Users/giovannidispoto/desktop/libui-master/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/giovannidispoto/desktop/libui-master /Users/giovannidispoto/desktop/libui-master/examples /Users/giovannidispoto/desktop/libui-master/build /Users/giovannidispoto/desktop/libui-master/build/examples /Users/giovannidispoto/desktop/libui-master/build/examples/CMakeFiles/cpp-multithread.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : examples/CMakeFiles/cpp-multithread.dir/depend

