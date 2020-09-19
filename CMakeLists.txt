cmake_minimum_required(VERSION 3.7.2)

project(helloworld CXX)

set (CMAKE_CXX_STANDARD 17)

find_package(gRPC CONFIG REQUIRED)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

# This is just a convenience. 
# You should be able to set this to whatever folder you like.
set(PROTO_GENERATED_FOLDER ${CMAKE_CURRENT_BINARY_DIR})

set(PROJECT_SOURCE_FILES src/server.cc)

# Clang-Tidy
set(CMAKE_CXX_CLANG_TIDY 
    clang-tidy)

# Clang-format
include("clang_format")
clang_format(${PROJECT_SOURCE_FILES})

# Address/UB Sanitizers
include ("sanitizers")

# GRPC and Proto generation
include ("grpc")

grpc_generate("proto/helloworld.proto" 
    ${PROTO_GENERATED_FOLDER}
    PROTO_SRCS
    PROTO_HDRS
    GRPC_SRCS
    GRPC_HDRS)

# Finally building
add_executable(server 
    ${PROJECT_SOURCE_FILES}
    ${PROTO_SRCS}
    ${GRPC_SRCS})

# the destination for our generated files is CMAKE_CURRENT_BINARY
target_include_directories(server PRIVATE ${PROTO_GENERATED_FOLDER})
target_link_libraries(server PRIVATE gRPC::gpr gRPC::grpc gRPC::grpc++ gRPC::grpc++_alts gRPC::grpc++_reflection)
