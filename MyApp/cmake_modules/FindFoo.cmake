# We use Gtest just to save creating an example library.

find_path(gtest_INCLUDE_DIR gtest/gtest.h)
find_library(gtest_LIB NAMES gtest)
find_library(gtest_LIB_MAIN NAMES gtest_main)

# This checks that we have found everything listed
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(gtest
        REQUIRED_VARS gtest_LIB_MAIN gtest_LIB gtest_INCLUDE_DIR
        )

if(gtest_FOUND AND NOT TARGET foo::gtest)
    add_library(foo::gtest UNKNOWN IMPORTED)
    set_target_properties(foo::gtest PROPERTIES
            IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
            IMPORTED_LOCATION "${gtest_LIB}"
            INTERFACE_INCLUDE_DIRECTORIES "${gtest_INCLUDE_DIR}"
            )

    add_library(foo::gtest_main UNKNOWN IMPORTED)
    set_target_properties(foo::gtest_main PROPERTIES
            IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
            IMPORTED_LOCATION "${gtest_LIB_MAIN}"
            INTERFACE_INCLUDE_DIRECTORIES "${gtest_INCLUDE_DIR}"
            )
endif()
