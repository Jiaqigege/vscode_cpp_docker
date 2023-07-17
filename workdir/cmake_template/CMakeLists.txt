cmake_minimum_required(VERSION 3.10)

# - - - - - - - - - - 编译器设置 - - - - - - - - - -
set(m_ARCH x64)
if(${m_ARCH} MATCHES "arm64")
    set(CMAKE_C_COMPILER "/usr/bin/aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc")
    set(CMAKE_CXX_COMPILER "/usr/bin/aarch64-linux-gnu/bin/aarch64-linux-gnu-g++")
    set(DEPS_FIND_DIR "./lib/universal_lib/arm64")
elseif(${m_ARCH} MATCHES "armhf")
    set(CMAKE_C_COMPILER "/usr/bin/arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc")
    set(CMAKE_CXX_COMPILER "/usr/bin/arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++")
    set(DEPS_FIND_DIR "./lib/universal_lib/arm")
elseif(${m_ARCH} MATCHES "x64")
    set(CMAKE_C_COMPILER "/usr/bin/gcc-9")
    set(CMAKE_CXX_COMPILER "/usr/bin/g++-9")
    set(DEPS_FIND_DIR "./lib/universal_lib/x64")
else()
    message(FATAL_ERROR  "error: A matching compiler could not be found.")
endif()

message("${CMAKE_C_COMPILER}")

# - - - - - - - - - - C++标准设置 - - - - - - - - - - 
set(CMAKE_CXX_STANDARD 11)

# - - - - - - - - - - 工程名设置 - - - - - - - - - - 
project(TEST_PROJECT)

# - - - - - - - - - - 外部库查找 - - - - - - - - - - 

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
set(CMAKE_EXE_LINKER_FLAGS "")
set(CMAKE_BUILD_TYPE Debug)

# find_package(nlohmann_json REQUIRED PATHS ${DEPS_FIND_DIR} NO_DEFAULT_PATH)

# 生成compile_commands.json
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

#添加宏定义
add_definitions(-DLJQ_MACRO=1)

# 设置头文件目录
include_directories(${CMAKE_SOURCE_DIR}/include) 

# 设置lib目录
# LINK_DIRECTORIES(${DEPS_FIND_DIR}/iperf3/lib)

aux_source_directory(./src SRC_CODE)
aux_source_directory(. SRC_CODE)
add_executable(cmake_exe ${SRC_CODE})

#库连接选项
target_link_libraries(cmake_exe pthread)

