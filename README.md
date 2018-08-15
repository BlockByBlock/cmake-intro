# Modern CMake

To understand modern cmake, here are few stuffs to consider

* cmake_minimum_required >3
* Target is how cmake work, **target target target**
* Indicating the files to include e.g. set, add_library
* Indicating where the files are located e.g. target_include_directories
* Executable? add_executable
* Any installation required? Local or system-wide





## Targets  

.. and its Properties

What is target? Executable is a target. Library is a target. *But source files are properties.*

```cmake
add_executable(main helloworld.cpp)
target_link_libraries(main PRIVATE Foo)
target_compile_definitions(main PUBLIC Bar)
```

As you can see from the above example, `main` is the target



#### Target's properties

**INTERFACE**  does not build the target, it provides the target to the user of the target

Consider it as an *external* implementation

  ```cmake
target_compile_definitions(main INTERFACE Foo)
  ```

From the above example, the preprocessor definition `Foo` is defined in all targets e.g. `main` that 			depends on `Foo` but not in `Foo` itself.

:exclamation:  That means `Foo` has become a mere *INTERFACE* as the property declared it as



**PRIVATE** will build target to itself - and not passed them 

Consider it as an *internal* implementation

```cmake
target_include_directories(main PRIVATE Bar)
```

  causes the directory `Bar` to be searched for include files only by `main`

:exclamation: Similar to OOP, private makes the access exclusive to the target



**PUBLIC** is *both* interface and private

It has both property's properties

```cmake
target_include_directories(main PUBLIC Bar)
```

causes directory `Bar` to be searched for include files by `main` and in all targets depending on it via target_link_libraries

:exclamation: Bar is built (*not as interface only*) and is made available for access 





## Examples

##### Including a Library in project

If library is installed to a system directory e.g. usr/local, there will not be a need to do `target_include_directories`

When a library is done *right* - 

* .cmake file to make the library available *or*
* installed to a known location e.g. usr/local or within project directory

the library should be easily link with the following lines

```cmake
find_package(Foo)
target_link_libraries(main PRIVATE Foo)
```



##### Third Part Dependencies - FindFoo.cmake 

This part is work in progress still :x:

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





## Install vs Build

`INSTALL` is used to implement `$ make install`.  Using application from build/install directory *decides* whether there is a need to install.

If the software is used from source build, install can be ignored. 

```
$ cd project/build
$ ./main
```

... How running an application from source build is like.



However in a deployment perspective, installation will be preferred. By installing component into a well-known prefix (e.g. /usr, /opt), it is available system-wide.

```
$ main
```

 

If a project is built, install should generate <u>exports</u> - so user do no need to find module, and will be built like part of the project that uses the targets



##### Using EXPORT 

Export command creates a build-directory for exported target files. 

`EXPORT(..)` vs `INSTALL(EXPORT ..)`

* use EXPORT(..) for build trees

* use INSTALL(EXPORT ..) for install trees

  

##### INSTALL command

The INSTALL command can install targets, files, exports, directories

`ARCHIVE` - Static Library
`LIBRARY` - non-DLL platform shared library
`RUNTIME` - Executables
`FRAMEWORK` - OS-X shared library

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





### Random Stuff

- Don't use file(GLOB), cannot detect file changes well
- Don't use include_directories, use target_include_directories (but not with a path outside module)



## Reads

Daniel Pfeifer's Effective CMake [Link](https://www.youtube.com/watch?v=bsXLMQ6WgIk)

It's time to do cmake right [Link](https://pabloariasal.github.io/2018/02/19/its-time-to-do-cmake-right/)

Effective Modern CMake [Link](https://gist.github.com/mbinna/c61dbb39bca0e4fb7d1f73b0d66a4fd1)

Modern CMake [Link](https://github.com/toeb/moderncmake)

CMake-enabled libraries [Link](https://coderwall.com/p/qej45g/use-cmake-enabled-libraries-in-your-cmake-project-iii)