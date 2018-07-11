cmake_minimum_required(VERSION 3.5)
project(shared_lib)

# Set build to release  
set(CMAKE_BUILD_TYPE Release)

# Link header file
include_directories(include)

# GLOB allow all files to be added
# Bad habit 
#file(GLOB SOURCES "src/*.cpp")

# Generate the shared library from the sources
# Declare module
add_library(thisLibrary SHARED
    src/file1.cpp
    src/file2.cpp
)

# Declare flags
target_include_directories(thisLibrary PUBLIC include)

#Set the location for library installation -- i.e., /usr/lib in this case
# not really necessary in this example. Use "sudo make install" to apply
install(TARGETS testStudent DESTINATION /usr/lib)
