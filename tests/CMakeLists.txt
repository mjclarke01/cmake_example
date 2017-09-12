cmake_minimum_required(VERSION 3.5)

enable_testing()
# If GTest is installed in /usr/local or similar
#find_package(GTest REQUIRED)
#include_directories(${GTEST_INCLUDE_DIRS})
# Else add manually
#add_library(gtest_main STATIC IMPORTED)
#set_target_properties(gtest_main PROPERTIES
#        IMPORTED_LOCATION "${CMAKE_SOURCE_DIR}/googletest-release-1.8.0/build/googlemock/gtest/libgtest_main.a"
#        INTERFACE_INCLUDE_DIRECTORIES "${CMAKE_SOURCE_DIR}/googletest-release-1.8.0/googletest/include/"
#        )
#add_library(gtest STATIC IMPORTED)
#set_target_properties(gtest PROPERTIES
#        IMPORTED_LOCATION "${CMAKE_SOURCE_DIR}/googletest-release-1.8.0/build/googlemock/gtest/libgtest.a"
#        INTERFACE_INCLUDE_DIRECTORIES "${CMAKE_SOURCE_DIR}/googletest-release-1.8.0/googletest/include/"
#        )

find_package(Foo REQUIRED)
set(TEST_FILES unit_test.cpp)

add_executable(MyTest ${TEST_FILES})

# Use this if using find_package(GTest REQUIRED)
#target_link_libraries(MyTest ${GTEST_BOTH_LIBRARIES} ${GMOCK_LIB} ${PTHREAD})
# Other methods use this
target_link_libraries(MyTest gtest_main gtest pthread)

add_test(NAME my_test COMMAND MyTest)