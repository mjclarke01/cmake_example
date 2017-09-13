cmake_minimum_required(VERSION 3.5)

enable_testing()
# If GTest is installed in /usr/local or similar
#find_package(GTest REQUIRED)
#include_directories(${GTEST_INCLUDE_DIRS})

# Else use custom find_package
find_package(Foo REQUIRED)

set(TEST_FILES unit_test.cpp)

add_executable(MyTest ${TEST_FILES})

# Use this if using find_package(GTest REQUIRED)
#target_link_libraries(MyTest ${GTEST_BOTH_LIBRARIES} ${GMOCK_LIB})
# Other methods use this
target_link_libraries(MyTest gtest_main gtest)

if(UNIX)
    target_link_libraries(MyTest pthread)
endif(UNIX)

add_test(NAME my_test COMMAND MyTest)