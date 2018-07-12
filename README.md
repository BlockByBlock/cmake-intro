# Intro to CMake

### Reads

Daniel Pfeifer's Effective CMake [Link](https://www.youtube.com/watch?v=bsXLMQ6WgIk)

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

* Example

```
find_package(Bar 2.0 REQUIRED)
add _library(Foo ...)
target_link_libraries(Foo PRIVATE Bar::Bar)

install(TARGETS Foo EXPORT FooTargets
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  RUNTIME DESTINATION bin
  INCLUDES DESTINATION include
  )
install(EXPORT FooTargets
  FILE FooTargets.cmake
  NAMESPACE Foo::
  DESTINATION lib/cmake/Foo
  )
```

### Third Part Dependencies - FindFoo.cmake - not built with cmake

```
find_path(Foo_INCLUDE_DIR foo.h)
find_library(Foo_LIBRARY foo)
# Prevent appear on cache editor
mark_as_advanced(Foo_INCLUDE_DIR Foo_LIBRARY)

# Check REQUIRED and VERSION
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Foo
    REQUIRED_VARS Foo_LIBRARY Foo_INCLUDE_DIR
    )

if(Foo_FOUND AND NOT TARFET Foo::Foo)
    # UNKNOWN: do not know is shared or static
    add_library(Foo::Foo UNKNOWN IMPORTED)
    set_target_properties(Foo::Foo PROPERTIES
        IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
        IMPORTED_LOCATION "${Foo_LIBRARY}"
        INTERFACE_INCLUDE_DIRECTORIES "${Foo_INCLUDE_DIR}"
        )
endif()
```

### Header-only libraries
```
add_library(thirdLib INTERFACE)
target_include_directories(thirdLib INTERFACE include)
target_link_libraries(thirdLib INTERFACE anotherLib)
```
### Random Stuff

* Use Modern CMake (>3/0)

* Do not use CMAKE_CXX_FLAGS, diff on diff compilers, can't define properly

* Don't use file(GLOB), cannot detect file changes well

* Don't use include_directories, use target_include_directories (but not with a path outside module)

* Don't use target_link_libraries without specifying public/private/interface

* Forget add_compile_options(), link_directories(), link_libraries

* Avoid variables = avoid empty space 

* Export target not variables

* Consider use of CMakePackageConfigHelps

```
include(CMakePackageConfigHelpers)
write_basic_package_version_file("FooConfigVersion.cmake"
  VERSION ${Foo_VERSION}
  COMPARIBILITY SameMajorVersion
  )
install(FILES "FooConfig.cmake" "FooConfigVersion.cmake"
  DESTINATION lib/cmake/Foo
)
```

* Consider use of CMakeFindDependencyMacro

```
include(CMakeFindDependencyMacro)
find_dependency(Bar 2.0)
include("${CMAKE_CURRENT_LIST_DIR}/FooTargets.cmake")
```



