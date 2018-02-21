# cmake example [![Travis Status](https://travis-ci.org/mjclarke01/cmake_example.svg?branch=master)](https://travis-ci.org/mjclarke01/cmake_example)

An example of trying to use modern CMake practices, it includes:

* MyApp - a top-level application that depends on the two libraries
* MyLib - a simple library that doesn't create a cmake config, so requires extra effort in MyApp
* ThirdPartyLib - a library that creates a cmake config and, thus, doesn't require extra effort

## Building MyLib

```
mkdir _build
cd _build

# To build shared
cmake -DBUILD_SHARED_LIBS:BOOL=ON ..

# To build release
cmake -DCMAKE_BUILD_TYPE=Release ..

# To build debug
cmake -DCMAKE_BUILD_TYPE=Debug ..

# Linux
make
sudo make install

# Win32 command line
cmake --build .
```

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

# Linux
make
sudo make install

# Win32 command line
cmake --build .
```
