cmake_minimum_required(VERSION 2.8.9)
project (TestLibrary)

# For the shared library:
# Shared lib: .so
# Static lib: .a
set ( PROJECT_LINK_LIBS libShared.so )
link_directories( ~/maindirectory/subdirectory/build )
#set ( PROJECT_LINK_LIBS libtestStudent.a )
#link_directories( ~/maindirectory/subdirectory/build )

include_directories(~/maindirectory/subdirectory/include)

add_executable(libtest libtest.cpp)
target_link_libraries(libtest ${PROJECT_LINK_LIBS} )
