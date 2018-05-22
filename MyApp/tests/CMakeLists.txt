cmake_minimum_required(VERSION 3.2)

# Testing
enable_testing()

add_executable(MyTest PRIVATE unit_test.cpp)

# The compile features might be different for the unit tests
target_compile_features(MyTest PRIVATE cxx_constexpr)

# ThirdPartyLib is defined in the top-level cmake
target_link_libraries(MyTest PRIVATE
        #ThirdPartyLib::ThirdPartyLib
        gtest_main
        gmock_main
        )

add_test(NAME my_test COMMAND MyTest)
