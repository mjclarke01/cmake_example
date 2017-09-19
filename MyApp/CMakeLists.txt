cmake_minimum_required(VERSION 3.5)
project(my_app)

# Don't do this, instead specify what features of C++ 11/14/17 we need (if any) using target_compile_features.
#set(CMAKE_CXX_STANDARD 11)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${PROJECT_SOURCE_DIR}/cmake_modules")

# Note: if we include a library's source, then we can treat it like it is our library, e.g.
#add_subdirectory(someLibrary)

add_executable(Hello src/main.cpp)

# This line says the compiler must support lambda init captures.
# It is possible to put 'cxx_std_11' or 'cxx_std_14' and so on.
target_compile_features(Hello PRIVATE cxx_lambda_init_captures cxx_constexpr)

# Testing
enable_testing()

# GTest is installed in /usr/local or similar
find_package(GTest REQUIRED)

# Find the library - MODULE indicates the find file is part of this project.
find_package(ThirdPartyLib MODULE REQUIRED)

# Find the library - CONFIG indicates the file is in the system, e.g. /usr/local/lib/cmake
# This only works if the library has been 'make install'ed and creates a config file.
# Our example does, so this work work.
#find_package(ThirdPartyLib CONFIG REQUIRED)

add_executable(MyTest tests/unit_test.cpp)

# The compile features might be different for the unit tests
target_compile_features(MyTest PRIVATE cxx_constexpr)

# Don't need these because the find_package sorts all this out
#target_include_directories(MyTest PUBLIC ${GTEST_INCLUDE_DIRS})
#target_include_directories(MyTest PUBLIC ${ThirdPartyLib_INCLUDE_DIR})

# :: is a trick to stop cmake being too clever.
# If we don't use :: and mispell one of the library names cmake assumes it is a file rather than a target and is happy.
# However we will get a linker error later on. For example: try misspelling pthread below.
# :: is invalid in a file name, so cmake will complain if it cannot find the target.
# For example: try misspelling ThirdPartyLib::ThirdPartyLib.
# The :: form of the name is defined in FindFoo.cmake
target_link_libraries(MyTest
        ThirdPartyLib::ThirdPartyLib
        ${GTEST_BOTH_LIBRARIES}
        ${GMOCK_LIB}
        )

if(UNIX)
    # On unix need pthread
    target_link_libraries(MyTest pthread)
endif(UNIX)

add_test(NAME my_test COMMAND MyTest)
