cmake_minimum_required(VERSION 3.5)
project(static_lib)
set(CMAKE_BUILD_TYPE Release)
 
# Include header file
include_directories(include)
 
# GLOB allow all files to be added
#file(GLOB SOURCES "src/*.cpp")
 
# Generate the static library from the sources (NOTE THE DIFF: SHARED vs STATIC) 
add_library(testStudent STATIC ${SOURCES})
 
#Set the location for library installation -- i.e., /usr/lib in this case
# not really necessary in this example. Use "sudo make install" to apply
install(TARGETS testStudent DESTINATION /usr/lib)
