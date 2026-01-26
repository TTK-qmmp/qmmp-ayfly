cmake_minimum_required(VERSION 3.0)

project(ayfly)

include_directories(z80ex)

add_definitions(-DDISABLE_AUDIO)

set(HEADERS
    AbstractAudio.h
    ay.h
    ayfly.h
    ayflyString.h
    Filter3.h
    z80ex/z80ex.h
    z80ex/z80ex_common.h
)

set(SOURCES
    AbstractAudio.cpp
    ay.cpp
    formats.cpp
    speccy.cpp
    lha.cpp
    common.cpp
    ayflyString.cpp
    Filter3.cpp
    z80ex/z80ex.c
)

add_library(${PROJECT_NAME} STATIC ${SOURCES} ${HEADERS})
set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME ${PROJECT_NAME}${STATIC_LIB_SUFFIX})

install(TARGETS ${PROJECT_NAME}
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    COMPONENT library
)

install(FILES ${HEADERS} DESTINATION ${CMAKE_INSTALL_PREFIX}/include/lib${PROJECT_NAME})
