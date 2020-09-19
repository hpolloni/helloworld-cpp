

macro(grpc_generate
    PROTO_FILE
    PROTO_GENERATED_FOLDER
    PROTO_SRCS
    PROTO_HDRS
    GRPC_SRCS
    GRPC_HDRS)

    find_program(PROTOC protoc REQUIRED)
    find_program(GRPC_CPP_PLUGIN grpc_cpp_plugin REQUIRED)
    
    get_filename_component(absolute_proto_file ${PROTO_FILE} ABSOLUTE)
    get_filename_component(proto_path "${absolute_proto_file}" PATH)
    get_filename_component(proto_name ${PROTO_FILE} NAME_WE)

    set(${PROTO_SRCS} "${PROTO_GENERATED_FOLDER}/${proto_name}.pb.cc")
    set(${PROTO_HDRS} "${PROTO_GENERATED_FOLDER}/${proto_name}.pb.h")
    set(${GRPC_SRCS} "${PROTO_GENERATED_FOLDER}/${proto_name}.grpc.pb.cc")
    set(${GRPC_HDRS} "${PROTO_GENERATED_FOLDER}/${proto_name}.grpc.pb.h")

    add_custom_command(
      OUTPUT "${${PROTO_SRCS}}" "${${PROTO_HDRS}}" "${${GRPC_SRCS}}" "${${GRPC_HDRS}}"
      COMMAND ${PROTOC}
      ARGS --grpc_out "${PROTO_GENERATED_FOLDER}"
        --cpp_out "${PROTO_GENERATED_FOLDER}"
        -I "${proto_path}"
        --plugin=protoc-gen-grpc="${GRPC_CPP_PLUGIN}"
        "${absolute_proto_file}"
      DEPENDS "${absolute_proto_file}")
endmacro()