

include(CheckCXXCompilerFlag)

set(CMAKE_REQUIRED_FLAGS "-Werror -faddress-sanitizer")
check_cxx_compiler_flag("-faddress-sanitizer" HAVE_FLAG_ADDRESS_SANITIZER)

set(CMAKE_REQUIRED_FLAGS "-Werror -fsanitize=address")
check_cxx_compiler_flag("-fsanitize=address" HAVE_FLAG_SANITIZE_ADDRESS)

set(CMAKE_REQUIRED_FLAGS "-Werror -fsanitize=undefined")
check_cxx_compiler_flag("-fsanitize=undefined" HAVE_FLAG_SANITIZE_UNDEFINED)

unset(CMAKE_REQUIRED_FLAGS)

if(HAVE_FLAG_SANITIZE_ADDRESS)
  set(SANITIZER_FLAG "-fsanitize=address")
  if (HAVE_FLAG_SANITIZE_UNDEFINED)
    set(SANITIZER_FLAG "${SANITIZER_FLAG},undefined")
  endif()
elseif(HAVE_FLAG_ADDRESS_SANITIZER)
  set(SANITIZER_FLAG "-faddress-sanitizer")
endif()

if(NOT SANITIZER_FLAG)
  return()
endif()

set(CMAKE_CXX_FLAGS_SANITIZER "-O1 -g ${SANITIZER_FLAG} -fno-omit-frame-pointer -fno-optimize-sibling-calls"
    CACHE STRING "Flags used by the C++ compiler during sanitizer builds."
    FORCE)
set(CMAKE_EXE_LINKER_FLAGS_SANITIZER "${SANITIZER_FLAG}"
    CACHE STRING "Flags used for linking binaries during sanitizer builds."
    FORCE)
set(CMAKE_SHARED_LINKER_FLAGS_SANITIZER "${SANITIZER_FLAG}"
    CACHE STRING "Flags used by the shared libraries linker sanitizer builds."
    FORCE)

mark_as_advanced(CMAKE_C_FLAGS_SANITIZER
    CMAKE_CXX_FLAGS_SANITIZER
    CMAKE_EXE_LINKER_FLAGS_SANITIZER
    CMAKE_SHARED_LINKER_FLAGS_SANITIZER)