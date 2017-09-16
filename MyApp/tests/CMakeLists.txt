cmake_minimum_required(VERSION 3.5)

enable_testing()
# 1) If GTest is installed in /usr/local or similar
#find_package(GTest REQUIRED)
#include_directories(${GTEST_INCLUDE_DIRS})

# add_executable(MyTest unit_test.cpp)

#target_link_libraries(MyTest ${GTEST_BOTH_LIBRARIES} ${GMOCK_LIB})

# 2) Instead use custom find_package - contrived example using Gtest
find_package(Foo REQUIRED)

add_executable(MyTest unit_test.cpp)

# :: is a trick to stop cmake being too clever.
# If we don't use :: and mispell one of the library names cmake assumes it is a file rather than a target and is happy.
# However we will get a linker error later on. For example: try misspelling pthread below.
# :: is invalid in a file name, so cmake will complain if it cannot find the target. For example: try misspelling gtest.
# The :: form of the name is defined in FindFoo.cmake
target_link_libraries(MyTest foo::gtest_main foo::gtest)

# 3) If we include Gtest's source, then we can treat it like it is our library.
# Requires a line uncommenting in the main CMakeLists.txt
#add_executable(MyTest unit_test.cpp)

#target_link_libraries(MyTest gtest_main gtest)

# The following lines apply to all examples - do not comment out.

# This line says the compiler must support constexpr.
# It is possible to put 'cxx_std_11' or 'cxx_std_14'
target_compile_features(MyTest PRIVATE cxx_constexpr)

if(UNIX)
    target_link_libraries(MyTest pthread)
endif(UNIX)

add_test(NAME my_test COMMAND MyTest)
