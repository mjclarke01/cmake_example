cmake_minimum_required(VERSION 3.5)
project(cmake_example)

set(CMAKE_CXX_STANDARD 11)

if (MSVC)
    add_compile_options(/W4)
else()
    add_compile_options(-Wall -Wextra -Wpedantic)
endif()

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${PROJECT_SOURCE_DIR}/cmake_modules")

# Uncomment this if we want to build googletest as part of the overall build
# add_subdirectory(googletest-release-1.8.0)
add_subdirectory(src)
add_subdirectory(tests)
