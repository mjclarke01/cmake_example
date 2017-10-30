cmake_minimum_required(VERSION 3.2)
project(MyLib VERSION 0.1 LANGUAGES CXX)

# A simple library that doesn't include any stuff to make it easier to use via cmake.
# ThirdPartyLib shows how to make it easier for cmake projects.

# Must use GNUInstallDirs to install libraries into correct locations on all platforms.
include(GNUInstallDirs)

add_library(MyLib src/printer.cpp)

set_target_properties(MyLib PROPERTIES VERSION ${PROJECT_VERSION})

# This line says the compiler must support lambda init captures and constexpr.
# It is possible to put 'cxx_std_11' or 'cxx_std_14' and so on.
target_compile_features(MyLib PRIVATE cxx_lambda_init_captures cxx_constexpr)

# Specifies the headers used for building the library.
# BUILD_INTERFACE tells CMake where the headers are for the 'make'.
# INSTALL_INTERFACE tells CMake where the headers should be installed on a 'make install'.
target_include_directories(MyLib PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/>
        $<INSTALL_INTERFACE:include/MyLib>
        )

# 'make install' to the correct locations (provided by GNUInstallDirs).
install(TARGETS MyLib EXPORT ThirdPartyLibConfig
        ARCHIVE  DESTINATION ${CMAKE_INSTALL_LIBDIR}
        LIBRARY  DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME  DESTINATION ${CMAKE_INSTALL_BINDIR})  # This is for Windows
install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

