cmake_minimum_required(VERSION 3.5)
project(cmake_example)

# Don't do this, instead specify what features of C++ 11 we need (if any) using target_compile_features.
# See tests/CMakeList.txt for an example.
#set(CMAKE_CXX_STANDARD 11)


if (MSVC)
    add_compile_options(/W4)
else()
    add_compile_options(-Wall -Wextra -Wpedantic)
endif()

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${PROJECT_SOURCE_DIR}/cmake_modules")

# Uncomment this if we want to build googletest within the project, see 3) in tests/CMakeLists.txt
#add_subdirectory(googletest-release-1.8.0)
add_subdirectory(src)
add_subdirectory(tests)
