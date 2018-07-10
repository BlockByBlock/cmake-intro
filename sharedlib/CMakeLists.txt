cmake_minimum_required(VERSION 2.8.9)
project(shared_lib)

# Set build to release  
set(CMAKE_BUILD_TYPE Release)

# Link header file
include_directories(include)

# GLOB allow all files to be added
file(GLOB SOURCES "src/*.cpp")

#Generate the shared library from the sources
add_library(thisLibrary SHARED ${SOURCES})

#Set the location for library installation -- i.e., /usr/lib in this case
# not really necessary in this example. Use "sudo make install" to apply
install(TARGETS testStudent DESTINATION /usr/lib)
