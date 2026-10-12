cmake_minimum_required(VERSION 3.22 FATAL_ERROR)

# Base configurations and settings for the project
include(BaseConfig)
include(GNUInstallDirs)

# Import configurations, source definitions, and linker settings
include(CrystalLib)

# Define main executable target, set it up and link to main library
add_executable(${PROJECT_NAME} main.cpp)

if(MSVC)
    # Add executable icon for Windows
    target_sources(${PROJECT_NAME} PRIVATE ../cmake/crystalserver.rc)
endif()

setup_target(${PROJECT_NAME})
set_output_directory(${PROJECT_NAME})
target_link_libraries(${PROJECT_NAME} PRIVATE ${PROJECT_NAME}_lib)

# Configurar IPO e Linkagem Incremental para o executável
configure_linking(${PROJECT_NAME})

# Compiler warnings and options
if (UNIX)
    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        target_compile_options(${PROJECT_NAME}_lib PRIVATE -Wall -Wextra -Wpedantic)
        target_compile_options(${PROJECT_NAME} PRIVATE -Wall -Wextra -Wpedantic)
    endif()
endif()

# Keep production LTO while optionally avoiding repeated whole-program test links.
if((BUILD_TESTS OR PACKAGE_TESTS) AND NOT ENABLE_TEST_LTO AND CMAKE_BUILD_TYPE MATCHES "^(Release|RelWithDebInfo|MinSizeRel)$")
    get_target_property(test_sources ${PROJECT_NAME}_lib SOURCES)
    add_library(crystalserver_testlib STATIC ${test_sources})
    foreach(property IN ITEMS
            INCLUDE_DIRECTORIES INTERFACE_INCLUDE_DIRECTORIES
            COMPILE_DEFINITIONS INTERFACE_COMPILE_DEFINITIONS
            COMPILE_OPTIONS INTERFACE_COMPILE_OPTIONS
            LINK_LIBRARIES INTERFACE_LINK_LIBRARIES
            LINK_OPTIONS INTERFACE_LINK_OPTIONS
            CXX_STANDARD CXX_STANDARD_REQUIRED CXX_EXTENSIONS
            UNITY_BUILD UNITY_BUILD_BATCH_SIZE
            PRECOMPILE_HEADERS INTERFACE_PRECOMPILE_HEADERS MSVC_RUNTIME_LIBRARY)
        get_target_property(value ${PROJECT_NAME}_lib ${property})
        if(NOT value STREQUAL "value-NOTFOUND")
            if(property MATCHES "^(INTERFACE_)?(COMPILE|LINK)_OPTIONS$")
                list(FILTER value EXCLUDE REGEX "^(/GL|/LTCG(:.*)?|-flto(=.*)?)$")
            endif()
            set_property(TARGET crystalserver_testlib PROPERTY ${property} "${value}")
        endif()
    endforeach()
    set_property(TARGET crystalserver_testlib PROPERTY INTERPROCEDURAL_OPTIMIZATION FALSE)
endif()
