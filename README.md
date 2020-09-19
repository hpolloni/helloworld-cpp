### A Hello World gRPC service
This is a simple template "Hello World" gRPC C++ service. It's based on the gRPC "Hello World" service from Google, but adds sanitizers and other static analysis tools that any sane C++ developer should use.

* clang-tidy
* clang-format
* asan
* ubsan

### Prep
#### Install vcpkg
```
$ git clone https://github.com/microsoft/vcpkg
$ ./vcpkg/bootstrap-vcpkg.sh
```

#### Install gRPC
```
$ ./vcpkg/vcpkg install grpc
```
#### Install clang-tidy and clang-format
```
$ brew install llvm
$ ln -s "$(brew --prefix llvm)/bin/clang-format" "/usr/local/bin/clang-format"
$ ln -s "$(brew --prefix llvm)/bin/clang-tidy" "/usr/local/bin/clang-tidy"
```

### Build
```
$ git clone https://github.com/hpolloni/helloworld-cpp
$ cd helloworld-cpp
$ mkdir build
$ cd build
$ cmake .. -DCMAKE_TOOLCHAIN_FILE=[vcpkg path]/scripts/buildsystems/vcpkg.cmake
```

#### A/UBSan
Enabling address and ub sanitizers is enabled by using a cmake build type. 
```
$ cmake .. -DCMAKE_TOOLCHAIN_FILE=[vcpkg path]/scripts/buildsystems/vcpkg.cmake -DCMAKE_BUILD_TYPE=SANITIZER
```

### FAQ
#### Why?
I love C++ because of the power that it gives me. But with great power comes great responsibility. Writing good, correct, efficient C++ is hard and bugs are easy to slip when the only tool is your compiler. This is why professional C++ developers use an array of static analysis tools at their disposal to find bugs at build time. Unfortunately, setting this tooling and integrating it with your code is sometimes difficult, even more so for beginners.

#### Why gRPC?
I wanted a non-trivial example, I also wanted something that it's short enough for people to focus on the build system and not necessarily the actual code. I think a "Hello World" gRPC service provides a balance between non-trivial build system and almost trivial code.

#### I use [conan, build2, etc]. Why vcpkg?
Vcpkg is what I use for my personal projects. By using a toolchain file it allows me to write clean cmake without introducing weird integration points (like conan used to do). Having said that, you should be able to use this package without a package manager, but it's not a goal for this package to do that.

#### I want to disable clang-tidy. How I do that?
Please don't. You can disable a specific rule or use the `NOLINT` comment to suppress specific lines of code. See https://clang.llvm.org/extra/clang-tidy/#suppressing-undesired-diagnostics

