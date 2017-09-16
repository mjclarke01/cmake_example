cmake_minimum_required(VERSION 3.5)
project(my_app)

# Don't do this, instead specify what features of C++ 11 we need (if any) using target_compile_features.
#set(CMAKE_CXX_STANDARD 11)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${PROJECT_SOURCE_DIR}/cmake_modules")

# Note: if we include a library's source, then we can treat it like it is our library.
#add_subdirectory(someLibrary)
add_subdirectory(src)
add_subdirectory(tests)
