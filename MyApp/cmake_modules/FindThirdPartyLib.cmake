find_path(ThirdPartyLib_INCLUDE_DIR ThirdPartyLib/third_party_lib.h)
find_library(ThirdPartyLib_LIB NAMES ThirdPartyLib)

# This checks that we have found everything listed
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ThirdPartyLib
        REQUIRED_VARS ThirdPartyLib_LIB ThirdPartyLib_INCLUDE_DIR
        )

if(ThirdPartyLib_FOUND AND NOT TARGET ThirdPartyLib::ThirdPartyLib)
    add_library(ThirdPartyLib::ThirdPartyLib UNKNOWN IMPORTED)
    set_target_properties(ThirdPartyLib::ThirdPartyLib PROPERTIES
            IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
            IMPORTED_LOCATION "${ThirdPartyLib_LIB}"
            INTERFACE_INCLUDE_DIRECTORIES "${ThirdPartyLib_INCLUDE_DIR}"
            )
endif()
