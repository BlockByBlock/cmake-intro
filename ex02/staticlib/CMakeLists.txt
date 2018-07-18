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
add_executable(st_test test/static_test.cpp)
target_link_libraries(st_test staticlib)
add_test(st_test st_test)

# Install target
install(TARGETS staticlib
    ARCHIVE DESTINATION lib
    INCLUDES DESTINATION include
)

# Install public include
install(FILES
    include/static.h
    DESTINATION include
)



