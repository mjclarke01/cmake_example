# cmake example [![Travis Status](https://travis-ci.org/mjclarke01/cmake_example.svg?branch=master)](https://travis-ci.org/mjclarke01/cmake_example)

An example of trying to use modern CMake practices.


## Building ThirdPartyLib

```
mkdir _build
cd _build

# To build shared
cmake -DBUILD_SHARED_LIBS:BOOL=ON ..

# To build release
cmake -DCMAKE_BUILD_TYPE=Release ..

# To build debug
cmake -DCMAKE_BUILD_TYPE=Debug ..
