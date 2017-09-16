cmake_minimum_required(VERSION 3.5)

enable_testing()

# GTest is installed in /usr/local or similar
find_package(GTest REQUIRED)
include_directories(${GTEST_INCLUDE_DIRS})

# Use custom Find Module file
find_package(ThirdPartyLib REQUIRED)
# Do we need this?
include_directories(${ThirdPartyLib_INCLUDE_DIR})

add_executable(MyTest unit_test.cpp)

# :: is a trick to stop cmake being too clever.
# If we don't use :: and mispell one of the library names cmake assumes it is a file rather than a target and is happy.
# However we will get a linker error later on. For example: try misspelling pthread below.
# :: is invalid in a file name, so cmake will complain if it cannot find the target. For example: try misspelling gtest.
# The :: form of the name is defined in FindFoo.cmake
target_link_libraries(MyTest 
    ThirdPartyLib::ThirdPartyLib 
    ${GTEST_BOTH_LIBRARIES} 
    ${GMOCK_LIB}
)

# If we include a library's source, then we can treat it like it is our library.

# This line says the compiler must support constexpr.
# It is possible to put 'cxx_std_11' or 'cxx_std_14'
target_compile_features(MyTest PRIVATE cxx_constexpr)

if(UNIX)
    # On unix need pthread
    target_link_libraries(MyTest pthread)
endif(UNIX)

add_test(NAME my_test COMMAND MyTest)
