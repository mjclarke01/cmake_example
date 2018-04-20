# Use this type of Find module for 3rd party libraries that do not support CMake clients.
# i.e. they don't provide for using CMake to include them. For example: Boost doesn't but QT does.
cmake_minimum_required(VERSION 3.2)

find_path(MyLib_INCLUDE_DIR MyLib/printer.h)
find_library(MyLib_LIBRARY NAMES MyLib)
find_library(MyLib_LIBRARY_DEBUG NAMES MyLibd)
find_library(MyLib_LIBRARY_RELEASE NAMES MyLib)

# Finds the most appropriate library of those found above and assigns it to MyLib_LIBRARY.
# For example: if it can only find the debug library it chooses that.
# If it finds both then it includes both and the 'optimized' and 'debug' flags.
include(SelectLibraryConfigurations)
select_library_configurations(MyLib)

# Add DEBUG and RELEASE to the advanced tab of the GUI
mark_as_advanced(MyLib_LIBRARY_RELEASE MyLib_LIBRARY_DEBUG)
message("${MyLib_LIBRARY}")

if(NOT TARGET MyLib::MyLib)
    # UNKNOWN means we don't know (care?) if it is static or shared
    add_library(MyLib::MyLib UNKNOWN IMPORTED)
    # Add the include directory
    set_target_properties(MyLib::MyLib PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "${MyLib_INCLUDE_DIR}")

    # Set the configurations for the various library types found.

    # Not sure if we need this one. Other examples include it.
    # Surely it is the same as RELEASE? Or is it some sort of default?
    if(EXISTS "${MyLib_LIBRARY}")
        message("Found LIB " "${MyLib_LIBRARY}")
        set_target_properties(MyLib::MyLib PROPERTIES
                IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
                IMPORTED_LOCATION "${MyLib_LIBRARY}"
                )
    endif()
    if(EXISTS "${MyLib_LIBRARY_DEBUG}")
        message("Found DEBUG")
        set_property(TARGET MyLib::MyLib APPEND PROPERTY
                IMPORTED_CONFIGURATIONS DEBUG)
        set_target_properties(MyLib::MyLib PROPERTIES
                IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
                IMPORTED_LOCATION_DEBUG "${MyLib_LIBRARY_DEBUG}"
                )
    endif()
    if(EXISTS "${MyLib_LIBRARY_RELEASE}")
        message("Found RELEASE")
        set_property(TARGET MyLib::MyLib APPEND PROPERTY
                IMPORTED_CONFIGURATIONS RELEASE)
        set_target_properties(MyLib::MyLib PROPERTIES
                IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
                IMPORTED_LOCATION_RELEASE "${MyLib_LIBRARY_RELEASE}"
                )
    endif()

endif()

# This checks that we have found everything required.
# Uses the library name found above in select_library_configurations.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(MyLib
        REQUIRED_VARS MyLib_LIBRARY MyLib_INCLUDE_DIR
        )
message("${MyLib_LIBRARY}")
