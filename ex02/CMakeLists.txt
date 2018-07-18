cmake_minimum_required(VERSION 3.5)
project(ex02)

# enable cmake testing
enable_testing()

add_subdirectory(staticlib)

add_executable(main src/main.cpp)
target_link_libraries(main staticlib)
