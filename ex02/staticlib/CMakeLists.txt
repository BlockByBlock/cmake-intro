cmake_minimum_required(VERSION 3.5)
project(staticlib)

# Static library
add_library(staticlib STATIC
    src/static.cpp
    include/static.h
)

target_include_directories(staticlib
    PUBLIC include
    PRIVATE src
)

# For testing only
add_executable(sl_test
    test/static_test.cpp
)

target_link_libraries(sl_test
    staticlib
)

add_test(sl_test sl_test)

