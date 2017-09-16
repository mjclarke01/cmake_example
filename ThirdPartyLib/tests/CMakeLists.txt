cmake_minimum_required(VERSION 3.5)

enable_testing()

find_package(GTest REQUIRED)
include_directories(${GTEST_INCLUDE_DIRS})

add_executable(ThirdPartyTests unit_test.cpp)

target_link_libraries(ThirdPartyTests ${GTEST_BOTH_LIBRARIES} ${GMOCK_LIB})

# This line says the compiler must support constexpr.
# It is possible to put 'cxx_std_11' or 'cxx_std_14'
target_compile_features(ThirdPartyTests PRIVATE cxx_constexpr)

add_test(NAME third_party_tests COMMAND ThirdPartyTests)
