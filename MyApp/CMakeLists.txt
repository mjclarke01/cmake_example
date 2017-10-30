cmake_minimum_required(VERSION 3.2)
project(my_app)

# BEGIN GTEST download - this only seems to work if it is the top-level cmake file

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

# Don't do this, instead specify what features of C++ 11/14/17 we need (if any) using target_compile_features.
#set(CMAKE_CXX_STANDARD 11)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${PROJECT_SOURCE_DIR}/cmake_modules")

# Note: if we include a library's source, then we can treat it like it is our library, e.g.
#add_subdirectory(someLibrary)

add_executable(Hello src/main.cpp)

# This line says the compiler must support lambda init captures.
# It is possible to put 'cxx_std_11' or 'cxx_std_14' and so on.
target_compile_features(Hello PRIVATE cxx_lambda_init_captures cxx_constexpr)

# Find PCRE (or a similar library that has its own cmake config) is installed in /usr/local or similar
#find_package(PCRE REQUIRED)

# Find the library - MODULE indicates the find file is part of this project.
find_package(MyLib MODULE REQUIRED)

# Find the library - CONFIG indicates the file is in the system, e.g. /usr/local/lib/cmake
# This only works if the library has been 'make install'ed and creates a config file.
# Our example does, so this will work if we 'make install' ThirdPartyLib.
find_package(ThirdPartyLib CONFIG REQUIRED)

# Don't need these because the find_package sorts all this out
#target_include_directories(MyTest PUBLIC ${PCRE_INCLUDE_DIR})
#target_include_directories(MyTest PUBLIC ${MyLib_INCLUDE_DIR})
#target_include_directories(MyTest PUBLIC ${ThirdPartyLib_INCLUDE_DIR})

# :: is a trick to stop cmake being too clever.
# If we don't use :: and mispell one of the library names cmake assumes it is a file rather than a target and is happy.
# However we will get a linker error later on. For example: try misspelling pthread below.
# :: is invalid in a file name, so cmake will complain if it cannot find the target.
# For example: try misspelling ThirdPartyLib::ThirdPartyLib.
# The :: form of the name is defined in FindFoo.cmake
target_link_libraries(Hello
        ThirdPartyLib::ThirdPartyLib
        MyLib::MyLib
        )
# Note: if we were really using PCRE then would need to include PCRE_LIBRARIES in the target_link_libraries.

if(UNIX)
    # On unix include pthread
    target_link_libraries(Hello pthread)
endif(UNIX)

# All the cmake stuff for tests is in a separate directory, just to be a bit different
add_subdirectory(tests)
