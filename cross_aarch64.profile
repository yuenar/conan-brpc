include(default)

target_host=aarch64-niic-linux
cc_compiler=gcc
cxx_compiler=g++

SDKTARGETSYSROOT=/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux
#standalone_toolchain=/toolchain/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu
# also tried toolchain=/usr/aarch64-linux/gnu using standard Ubuntu apt packages

[settings]
arch=armv8
arch_build=x86_64
arch_target=armv8
os=Linux
os_build=Linux
os_target=Linux

build_type=Release
compiler=gcc
compiler.version=8.2
compiler.cppstd=11
compiler.libcxx=libstdc++11
compiler.threads=posix
[options]
boost:extra_b2_flags=cxxstd=11 compileflags=-march=armv8-a  compileflags=-mtune=cortex-a57.cortex-a53 compileflags=--sysroot=/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux
[conf]
####以下conf只为boost交叉编译使用

tools.build:sysroot=/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux
tools.cmake.cmaketoolchain:system_processor=aarch64
tools.build:cflags=['-march=armv8-a', '-mtune=cortex-a57.cortex-a53']
tools.build:compiler_executables={'asm': 'AS=/opt/niic-h/2.4.3/sysroots/x86_64-niic_sdk-linux/usr/bin/aarch64-niic-linux/aarch64-niic-linux-as', 'c': '/opt/niic-h/2.4.3/sysroots/x86_64-niic_sdk-linux/usr/bin/aarch64-niic-linux/aarch64-niic-linux-gcc', 'cpp': '/opt/niic-h/2.4.3/sysroots/x86_64-niic_sdk-linux/usr/bin/aarch64-niic-linux/aarch64-niic-linux-g++'}
tools.build:cxxflags=['-march=armv8-a', '-mtune=cortex-a57.cortex-a53']
tools.build:exelinkflags=['-march=armv8-a', '-mtune=cortex-a57.cortex-a53']
tools.build:sharedlinkflags=['-march=armv8-a', '-mtune=cortex-a57.cortex-a53']
tools.build:jobs=10

[env]
CHOST=aarch64-niic-linux
PKG_CONFIG_PATH=/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux/usr/lib64/pkgconfig:/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux/usr/share/pkgconfig
CONAN_CMAKE_FIND_ROOT_PATH=/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux
CONAN_CMAKE_SYSROOT=/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux
CONAN_CMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER
CONAN_CMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY
CONAN_CMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY
CONAN_CMAKE_FIND_ROOT_PATH_MODE_PACKAGE=ONLY
CONAN_LIBCXX=/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux/usr/lib64

#CONAN_DISABLE_CHECK_COMPILER=True
CMAKE_C_FLAGS "-Wall -g -std=c++11 -lpthread -I/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux/usr/include"
CMAKE_CXX_FLAGS "-Wall -g -std=c++11 -lpthread -I/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux/usr/include"
CMAKE_USE_PTHREADS_INIT=1
THREADS_PREFER_PTHREAD_FLAG=ON
CMAKE_THREAD_LIBS_INIT="-pthread"
CONAN_STD_CXX_FLAG=c++11
CONAN_CXX_FLAGS=-m32 -fno-gcse
CONAN_SHARED_LINKER_FLAGS=-m32
CONAN_C_FLAGS=-m32
CONAN_COMPILER=gcc
CONAN_COMPILER_VERSION=8.2
CROSS_ROOT=/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux
#CONAN_CMAKE_GENERATOR="Unix Makefiles"
PKG_CONFIG_SYSROOT_DIR=/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux
PKG_CONFIG_PATH=/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux/usr/lib64/pkgconfig:/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux/usr/share/pkgconfig
CONFIGURE_FLAGS="--target=aarch64-niic-linux --host=aarch64-niic-linux --build=x86_64-linux --with-libtool-sysroot=/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux"
CONAN_CMAKE_SYSROOT=/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux
SYSROOT=/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux
CC=/opt/niic-h/2.4.3/sysroots/x86_64-niic_sdk-linux/usr/bin/aarch64-niic-linux/aarch64-niic-linux-gcc -march=armv8-a -mtune=cortex-a57.cortex-a53 --sysroot=/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux
CXX=/opt/niic-h/2.4.3/sysroots/x86_64-niic_sdk-linux/usr/bin/aarch64-niic-linux/aarch64-niic-linux-g++ -march=armv8-a -mtune=cortex-a57.cortex-a53 --sysroot=/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux
CPP=/opt/niic-h/2.4.3/sysroots/x86_64-niic_sdk-linux/usr/bin/aarch64-niic-linux/aarch64-niic-linux-gcc -E  -march=armv8-a -mtune=cortex-a57.cortex-a53 --sysroot=/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux
CXXFLAGS="-I/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux/usr/include"  --sysroot=/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux
CFLAGS="-I/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux/usr/include"  --sysroot=/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux
LDFLAGS="-I/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux/usr/include -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed"
AR=/opt/niic-h/2.4.3/sysroots/x86_64-niic_sdk-linux/usr/bin/aarch64-niic-linux/aarch64-niic-linux-ar
AS=/opt/niic-h/2.4.3/sysroots/x86_64-niic_sdk-linux/usr/bin/aarch64-niic-linux/aarch64-niic-linux-as
RANLIB=/opt/niic-h/2.4.3/sysroots/x86_64-niic_sdk-linux/usr/bin/aarch64-niic-linux/aarch64-niic-linux-ranlib
LD=/opt/niic-h/2.4.3/sysroots/x86_64-niic_sdk-linux/usr/bin/aarch64-niic-linux/aarch64-niic-linux-ld --sysroot=/opt/niic-h/2.4.3/sysroots/aarch64-niic-linux
STRIP=/opt/niic-h/2.4.3/sysroots/x86_64-niic_sdk-linux/usr/bin/aarch64-niic-linux/aarch64-niic-linux-strip
OBJCOPY=/opt/niic-h/2.4.3/sysroots/x86_64-niic_sdk-linux/usr/bin/aarch64-niic-linux/aarch64-niic-linux-objcopy
FC=/opt/niic-h/2.4.3/sysroots/x86_64-niic_sdk-linux/usr/bin/aarch64-niic-linux/aarch64-niic-linux-gfortran

