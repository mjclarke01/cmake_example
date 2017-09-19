cmake_minimum_required(VERSION 3.5)
project(ThirdPartyLib VERSION 0.1 LANGUAGES CXX)

# BEGIN GTEST

# Google recommend including GTEST as an external project
if(UNIX)
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -std=gnu++11")
endif()

# Download and unpack googletest at configure time
configure_file(CMakeLists.txt.in googletest-download/CMakeLists.txt)
execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/googletest-download )
if(result)
  message(FATAL_ERROR "CMake step for googletest failed: ${result}")
endif()
execute_process(COMMAND ${CMAKE_COMMAND} --build .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/googletest-download )
if(result)
  message(FATAL_ERROR "Build step for googletest failed: ${result}")
endif()

# Prevent overriding the parent project's compiler/linker
# settings on Windows
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

# Add googletest directly to the build. This defines
# the gtest and gtest_main targets.
add_subdirectory(${CMAKE_BINARY_DIR}/googletest-src
                 ${CMAKE_BINARY_DIR}/googletest-build)

# END GTEST


# Must use GNUInstallDirs to install libraries into correct locations on all platforms.
include(GNUInstallDirs)

add_library(ThirdPartyLib src/third_party_lib.cpp)

# This line says the compiler must support lambda init captures and constexpr.
# It is possible to put 'cxx_std_11' or 'cxx_std_14' and so on.
target_compile_features(ThirdPartyLib PRIVATE cxx_lambda_init_captures cxx_constexpr)

# Specifies the headers used for building the library.
# BUILD_INTERFACE tells CMake where the headers are for the 'make'.
# INSTALL_INTERFACE tells CMake where the headers should be installed on a 'make install'.
target_include_directories(ThirdPartyLib PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/>
        $<INSTALL_INTERFACE:include/ThirdPartyLib>
        )

# 'make install' to the correct locations (provided by GNUInstallDirs).
install(TARGETS ThirdPartyLib EXPORT ThirdPartyLibConfig
        ARCHIVE  DESTINATION ${CMAKE_INSTALL_LIBDIR}
        LIBRARY  DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME  DESTINATION ${CMAKE_INSTALL_BINDIR})  # This is for Windows
install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# Creates and installs the config file which make the project importable.
install(EXPORT ThirdPartyLibConfig NAMESPACE ThirdPartyLib:: DESTINATION lib/cmake/ThirdPartyLib)

# Usually testing stuff
enable_testing()

add_executable(ThirdPartyTests tests/unit_test.cpp)

# The compile features might be different for the unit tests
target_compile_features(ThirdPartyTests PRIVATE cxx_constexpr)

target_link_libraries(ThirdPartyTests gtest_main gmock_main)

add_test(NAME third_party_tests COMMAND ThirdPartyTests)
