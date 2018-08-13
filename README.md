# Modern CMake



### Targets and Properties 

Executable is target. Library is target. Source files are properties.

* Properties

  **INTERFACE** use by users of target e.g. executable using the library

    e.g. target_compile_definitions(myTarget INTERFACE USE_MYTARGET)

    causes preprocessor definition USE_MYTARGET to be defined in all targets depending on myTarget but not in myTarget itself

  **PRIVATE** to build own target/implementation - not passed down

    e.g. target_include_directories(myTarget PRIVATE ./src)

    causes the directory ./src to be searched for include files only by myTarget

  **PUBLIC** both interface and private

    e.g. target_include_directories(myTarget PUBLIC ./include)

    causes directory ./include to be searched for include files by myTarget and in all targets depending on it via target_link_libraries



------

### Examples

##### External Modules/Libraries

```cmake
find_package(ExtMod)

target_include_directories(Main PRIVATE ${ExtMod_INCLUDE_DIRS})
target_link_libraries(Main PRIVATE ${ExtMod_BOTH_LIBS})
```



##### Third Part Dependencies - FindFoo.cmake - not built with cmake

```cmake
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

------



### Install vs Build

Using application from build/install directory decide whether there is a need to install

INSTALL is used to implement 'make install'. If the software is used from source build, install can be ignored. However in a deployment perspective, installation will be preferred. By installing component into a well-known prefix (e.g. /usr, /opt), it is available system-wide. 

If a project is built, install should generate exports - so user do no need to find module, and will be built like part of the project that uses the targets



##### Using EXPORT 

Export command creates a build-directory for exported target files. 

EXPORT(..) vs INSTALL(EXPORT ..)

* EXPORT(..) for build trees

* INSTALL(EXPORT ..) for install trees

  

##### INSTALL command

The INSTALL command can install targets, files, exports, directories

ARCHIVE - Static Library
LIBRARY - non-DLL platform shared library
RUNTIME - Executables
FRAMEWORK - OS-X shared library

```
install(TARGETS targets 
	LIBRARY DESTINATION bin)

install(FILES file.h 
	LIBRARY DESTINATION include)
```



##### Install for directories

```
target_include_directories(target
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)
```



------



### Random Stuff

- Don't use file(GLOB), cannot detect file changes well
- Don't use include_directories, use target_include_directories (but not with a path outside module)

------



### Reads

Daniel Pfeifer's Effective CMake [Link](https://www.youtube.com/watch?v=bsXLMQ6WgIk)

It's time to do cmake right [Link](https://pabloariasal.github.io/2018/02/19/its-time-to-do-cmake-right/)

Effective Modern CMake [Link](https://gist.github.com/mbinna/c61dbb39bca0e4fb7d1f73b0d66a4fd1)

Modern CMake [Link](https://github.com/toeb/moderncmake)

CMake-enabled libraries [Link](https://coderwall.com/p/qej45g/use-cmake-enabled-libraries-in-your-cmake-project-iii)