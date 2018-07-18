cmake_minimum_required(VERSION 3.5)
project(sharedlib)

# Shared library
add_library(sharedlib SHARED
    src/shared.cpp
    include/shared.h
)

target_include_directories(sharedlib
    PUBLIC include
    PRIVATE src
)

# For testing only
add_executable(sh_test test/shared_test.cpp)
target_link_libraries(sh_test sharedlib)
add_test(sh_test sh_test)

# Install target
install(TARGETS sharedlib
    LIBRARY DESTINATION lib
    INCLUDES DESTINATION include
)

# Install public include
install(FILES
    include/shared.h
    DESTINATION include
)
