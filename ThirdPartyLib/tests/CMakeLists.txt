cmake_minimum_required(VERSION 3.5)

# Usually testing stuff                 
enable_testing()

add_executable(ThirdPartyTests unit_test.cpp)

target_link_libraries(ThirdPartyTests gtest_main gmock_main)

# Not entirely sure what this all does
target_include_directories(ThirdPartyTests PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/../include/>
  $<INSTALL_INTERFACE:include/ThirdPartyLib>
)

# This line says the compiler must support constexpr.
# It is possible to put 'cxx_std_11' or 'cxx_std_14'
target_compile_features(ThirdPartyTests PRIVATE cxx_constexpr)

add_test(NAME third_party_tests COMMAND ThirdPartyTests)
