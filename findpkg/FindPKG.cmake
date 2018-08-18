##############################################################################
# Find a package
#
# Some variables to consider:
# PKG_INCLUDE DIRS - Header files .h
# PKG_LIBRARIES - Libraries for building the pkg
# PKG_DEFINITIONS - add_definitions(${PKG_DEFINITIONS})
# PKG_FOUND - If false do not use
# PKG_VERSION
##############################################################################
# By Yeap Bing Cheng <ybingcheng@gmail.com>
#
# Some useful variables to make known:
# 	PKG_FOUND
# 	PKG_INCLUDE_DIRS
# 	PKG_LIBRARIES
# 	
##############################################################################

find_path(PKG_INCLUDE_DIRS
	NAMES
		pkg.h
	PATHS
		$ENV{PKG_HOME}/include
	PATH_SUFFIXES
		subdir
)

# Find libraries
find_library(LIBRARY_ONE
	NAMES
		library_one
	PATHS
		$ENV{PKG_HOME}/library_one
)

find_library(LIBRARY_TWO
	NAMES
		library_two
	PATHS
		$ENV{PKG_HOME}/library_two
)

if (LIBRARY_ONE AND LIBRARY_TWO)
	set(PKG_LIBRARIES
		${LIBRARY_ONE}
		${LIBRARY_TWO}
	)
endif()

# For cache
mark_as_advanced(PKG_INCLUDE_DIRS PKG_LIBRARIES)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(PKG
	REQUIRED_VARS PKG_INCLUDE_DIRS
)

if(PKG_INCLUDE_DIRS AND PKG_LIBRARIES)
	set(PKG_FOUND true)
endif()

if(PKG_FOUND)
	message(STATUS "Found Package!": ${PKG_LIBRARIES})
endif()

if(PKG_FOUND AND NOT TARGET PKG::PKG)
	add_library(PKG::PKG INTERFACE IMPORTED)
	set_target_properties(PKG::PKG PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES "${PKG_INCLUDE_DIRS}"
)
endif()


