# Most of the code in here comes from http://mariobadr.com/using-clang-format-to-enforce-style.html

find_program(CLANG_FORMAT NAMES "clang-format" DOC "Path to clang-format executable" )

if(NOT CLANG_FORMAT)
    message(FATAL_ERROR "clang-format not found.")
else()
    set(DO_CLANG_FORMAT "${CLANG_FORMAT}" "-i -style=file")
endif()

function(prepend var prefix)
    set(listVar "")
    foreach(f ${ARGN})
        message(STATUS ${f})
        list(APPEND listVar "${prefix}/${f}")
    endforeach()
    set(${var} "${listVar}" PARENT_SCOPE)
endfunction()

macro(clang_format PROJECT_FILES)
    if(CLANG_FORMAT)
        prepend(FILES_TO_FORMAT ${CMAKE_CURRENT_SOURCE_DIR} ${PROJECT_FILES})
        message(STATUS ${FILES_TO_FORMAT})
        # TODO: make the main target depend on this target.
        # Right now, I don't know when is clang-format run as part of a build
        add_custom_target(
            clangformat ALL
            COMMAND ${CLANG_FORMAT} -i -style=file ${FILES_TO_FORMAT})
    endif()
endmacro()
