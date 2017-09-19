# Use this type of Find module for 3rd party libraries that do not support CMake clients.
# i.e. they don't provide for using CMake to include them. For example: Boost doesn't but QT does.
cmake_minimum_required(VERSION 3.5)

find_path(ThirdPartyLib_INCLUDE_DIR ThirdPartyLib/third_party_lib.h)
find_library(ThirdPartyLib_LIBRARY NAMES ThirdPartyLib)
find_library(ThirdPartyLib_LIBRARY_DEBUG NAMES ThirdPartyLibd)
find_library(ThirdPartyLib_LIBRARY_RELEASE NAMES ThirdPartyLib)

# Finds the most appropriate library of those found above and assigns it to ThirdPartyLib_LIBRARY.
# For example: if it can only find the debug library it chooses that.
# If it finds both then it includes both and the 'optimized' and 'debug' flags.
include(SelectLibraryConfigurations)
select_library_configurations(ThirdPartyLib)

# Add DEBUG and RELEASE to the advanced tab of the GUI
mark_as_advanced(ThirdPartyLib_LIBRARY_RELEASE ThirdPartyLib_LIBRARY_DEBUG)
message("${ThirdPartyLib_LIBRARY}")

if(NOT TARGET ThirdPartyLib::ThirdPartyLib)
    # UNKNOWN means we don't know (care?) if it is static or shared
    add_library(ThirdPartyLib::ThirdPartyLib UNKNOWN IMPORTED)
    # Add the include directory
    set_target_properties(ThirdPartyLib::ThirdPartyLib PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "${ThirdPartyLib_INCLUDE_DIR}")

    # Set the configurations for the various library types found.

    # Not sure if we need this one. Other examples include it.
    # Surely it is the same as RELEASE? Or is it some sort of default?
    if(EXISTS "${ThirdPartyLib_LIBRARY}")
        message("Found LIB " "${ThirdPartyLib_LIBRARY}")
        set_target_properties(ThirdPartyLib::ThirdPartyLib PROPERTIES
                IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
                IMPORTED_LOCATION "${ThirdPartyLib_LIBRARY}"
                )
    endif()
    if(EXISTS "${ThirdPartyLib_LIBRARY_DEBUG}")
        message("Found DEBUG")
        set_property(TARGET ThirdPartyLib::ThirdPartyLib APPEND PROPERTY
                IMPORTED_CONFIGURATIONS DEBUG)
        set_target_properties(ThirdPartyLib::ThirdPartyLib PROPERTIES
                IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
                IMPORTED_LOCATION_DEBUG "${ThirdPartyLib_LIBRARY_DEBUG}"
                )
    endif()
    if(EXISTS "${ThirdPartyLib_LIBRARY_RELEASE}")
        message("Found RELEASE")
        set_property(TARGET ThirdPartyLib::ThirdPartyLib APPEND PROPERTY
                IMPORTED_CONFIGURATIONS RELEASE)
        set_target_properties(ThirdPartyLib::ThirdPartyLib PROPERTIES
                IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
                IMPORTED_LOCATION_RELEASE "${ThirdPartyLib_LIBRARY_RELEASE}"
                )
    endif()

endif()

# This checks that we have found everything required.
# Uses the library name found above in select_library_configurations.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ThirdPartyLib
        REQUIRED_VARS ThirdPartyLib_LIBRARY ThirdPartyLib_INCLUDE_DIR
        )
message("${ThirdPartyLib_LIBRARY}")