cmake_minimum_required(VERSION 3.2)
project(MyHeaderLib VERSION 0.1 LANGUAGES CXX)

# Must use GNUInstallDirs to install libraries into correct locations on all platforms.
include(GNUInstallDirs)

# Because it is header only we use INTERFACE to indicate that we are not supplying source files
add_library(MyHeaderLib INTERFACE)

# Cannot set properties on INTERFACE?
#set_target_properties(MyHeaderLib PROPERTIES VERSION ${PROJECT_VERSION})

# This line says the compiler must support lambda init captures and constexpr.
# It is possible to put 'cxx_std_11' or 'cxx_std_14' and so on.
target_compile_features(MyHeaderLib INTERFACE cxx_lambda_init_captures cxx_constexpr)

# Specifies the headers used for building the library.
# BUILD_INTERFACE tells CMake where the headers are for the 'make'.
# INSTALL_INTERFACE tells CMake where the headers should be installed on a 'make install'.
target_include_directories(MyHeaderLib INTERFACE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/>
        $<INSTALL_INTERFACE:include/MyHeaderLib>
        )

target_link_libraries(MyHeaderLib INTERFACE)

# 'make install' to the correct locations (provided by GNUInstallDirs).
install(TARGETS MyHeaderLib EXPORT MyHeaderLibConfig
        ARCHIVE  DESTINATION ${CMAKE_INSTALL_LIBDIR}
        LIBRARY  DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME  DESTINATION ${CMAKE_INSTALL_BINDIR})  # This is for Windows
install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# Creates and installs the config file which make the project importable.
install(EXPORT MyHeaderLibConfig NAMESPACE MyHeaderLib:: DESTINATION lib/cmake/MyHeaderLib)