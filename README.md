# cmake example [![Travis Status](https://travis-ci.org/mjclarke01/cmake_example.svg?branch=master)](https://travis-ci.org/mjclarke01/cmake_example)

An example of trying to use modern CMake practices, it includes:

* MyApp - a top-level application that depends on the two libraries
* MyLib - a simple library that doesn't create a cmake config, so requires extra effort in MyApp
* ThirdPartyLib - a library that creates a cmake config and, thus, doesn't require extra effort
* MyHeaderLib - a header-only library that creates a cmake config and, thus, doesn't require extra effort

## Configuring and building MyLib

```
mkdir _build
cd _build

# To configure for a release build
cmake -DCMAKE_BUILD_TYPE=Release ..

# To configure for a debug build
cmake -DCMAKE_BUILD_TYPE=Debug ..

# To configure for a shared build
cmake -DBUILD_SHARED_LIBS:BOOL=ON -DCMAKE_BUILD_TYPE=Debug ..

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

# To configure for a release build
cmake -DCMAKE_BUILD_TYPE=Release ..

# To configure for a debug build
cmake -DCMAKE_BUILD_TYPE=Debug ..

# To configure for a shared build
cmake -DBUILD_SHARED_LIBS:BOOL=ON -DCMAKE_BUILD_TYPE=Debug ..

# Linux
make
sudo make install

# Win32 command line
cmake --build .
```

## Building MyHeaderLib
```
mkdir _build
cd _build

# Build
cmake ..

# Linux
# Call make to generate cmake config
make
sudo make install
```

## Notes
* Not setting the CMake build type doesn't necessarily mean it builds debug - it may build an empty build type (depends on the compiler and linker). It is better to be explicit.
