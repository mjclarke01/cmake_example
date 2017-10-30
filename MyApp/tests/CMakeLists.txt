cmake_minimum_required(VERSION 3.2)

# BEGIN GTEST download

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
# NOTE: I added EXCLUDE_FROM_ALL to stop 'make install' installing gtest as well.
add_subdirectory(${CMAKE_BINARY_DIR}/googletest-src
        ${CMAKE_BINARY_DIR}/googletest-build EXCLUDE_FROM_ALL)

# END GTEST download

# Testing
enable_testing()

add_executable(MyTest unit_test.cpp)

# The compile features might be different for the unit tests
target_compile_features(MyTest PRIVATE cxx_constexpr)

# ThirdPartyLib is defined in the top-level cmake
target_link_libraries(MyTest
        ThirdPartyLib::ThirdPartyLib
        gtest_main
        gmock_main
        )

add_test(NAME my_test COMMAND MyTest)