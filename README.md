# Intro to CMake

### Reads

It's time to do cmake right [Link](https://pabloariasal.github.io/2018/02/19/its-time-to-do-cmake-right/)

Effective Modern CMake [Link](https://gist.github.com/mbinna/c61dbb39bca0e4fb7d1f73b0d66a4fd1)

### Targets and Properties - Pablo Arias

Executable is target. Library is target. Source files are properties.

* Properties

  **INTERFACE** use by users of target e.g. executable using the library

  **PRIVATE** to build own target/implementation - not passed down

  **PUBLIC** both interface and private

### Dependencies

```
target_link_libraries(example
    PUBLIC
        Shared_class
    PRIVATE
        Internal_class
```

### External Modules

```
find_package(ExtMod)

add_executable(Main ..)

target_include_directories(Main
    PRIVATE ${ExtMod_INCLUDE_DIRS}
)

target_link_libraries(Main
     PRIVATE ${ExtMod_BOTH_LIBS}
)

```

### External Library

```
find_library(BAR_LIB bar HINTS ${BAR_DIR}/lib)
add_library(bar SHARED IMPORTED)
set_target_properties(bar PROPERTIES
             LOCATION ${BAR_LIB})
set target_properties(bar PROPERTIES
              INTERFACE_INCLUDE_DIRECTORIES ${BAR_DIR}/include)
              INTERFACE_LINK_LIBRARIES Boost::boost)
```

### Third Part Dependencies - xxxConfig.cmake

_Export target not variable!_


### Header-only libraries
```
add_library(thirdLib INTERFACE)
target_include_directories(thirdLib INTERFACE include)
target_link_libraries(thirdLib INTERFACE anotherLib)
```
### Random Stuff

* Use Modern CMake (>3/0)

* Get hands off CMAKE_CXX_FLAGS

* Don't use file(GLOB), cannot detect changes well

* Don't use include_directories, use target_include_directories (but not with a path outside module)

* Don't use target_link_libraries without specifying public/private/interface



