cmake_minimum_required(VERSION 3.5)

add_library(ThirdPartyLib third_party_lib.cpp)

# This line says the compiler must support lambda init captures.
# It is possible to put 'cxx_std_11' or 'cxx_std_14' and so on.
target_compile_features(ThirdPartyLib PRIVATE cxx_lambda_init_captures)