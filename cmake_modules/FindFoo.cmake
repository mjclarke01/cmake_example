find_path(GTEST_INCLUDE_DIR gtest/gtest.h)
find_library(GTEST_LIB NAMES gtest)
find_library(GTEST_LIB_MAIN NAMES gtest_main)

# This checks that we have found everything listed
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(GTEST
        REQUIRED_VARS GTEST_LIB_MAIN GTEST_LIB GTEST_INCLUDE_DIR
        )

if(GTEST_FOUND AND NOT TARGET GTEST)
    add_library(gtest UNKNOWN IMPORTED)
    set_target_properties(gtest PROPERTIES
            IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
            IMPORTED_LOCATION "${GTEST_LIB}"
            INTERFACE_INCLUDE_DIRECTORIES "${GTEST_INCLUDE_DIR}"
            )

    add_library(gtest_main UNKNOWN IMPORTED)
    set_target_properties(gtest_main PROPERTIES
            IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
            IMPORTED_LOCATION "${GTEST_LIB_MAIN}"
            INTERFACE_INCLUDE_DIRECTORIES "${GTEST_INCLUDE_DIR}"
            )
endif()
