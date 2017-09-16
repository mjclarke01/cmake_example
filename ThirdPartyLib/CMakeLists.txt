cmake_minimum_required(VERSION 3.5)
project(ThirdPartyLib)

# Don't do this, instead specify what features of C++ 11 we need (if any) using target_compile_features.
# See tests/CMakeList.txt for an example.
#set(CMAKE_CXX_STANDARD 11)

#add_subdirectory(src)
add_subdirectory(tests)
