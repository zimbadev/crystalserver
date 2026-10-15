find_package(ut CONFIG REQUIRED)

enable_testing()
set(CRYSTALSERVER_TEST_LIBRARY ${PROJECT_NAME}_lib)
if(TARGET crystalserver_testlib)
    set(CRYSTALSERVER_TEST_LIBRARY crystalserver_testlib)
endif()

function(setup_test TARGET_NAME DIR)
    add_executable(${TARGET_NAME} main.cpp)
    setup_target(${TARGET_NAME})

    target_compile_definitions(${TARGET_NAME} PUBLIC -DDEBUG_LOG)
    target_link_libraries(${TARGET_NAME}  PRIVATE Boost::ut ${CRYSTALSERVER_TEST_LIBRARY})
    target_include_directories(${TARGET_NAME} PRIVATE ${CMAKE_SOURCE_DIR}/tests/fixture PRIVATE ${CMAKE_SOURCE_DIR}/tests/${DIR})

    if(SPEED_UP_BUILD_UNITY AND (CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo" OR CMAKE_BUILD_TYPE STREQUAL "Release"))
        set_target_properties(${TARGET_NAME} PROPERTIES UNITY_BUILD ON)
        log_option_enabled("Build unity for speed up compilation for target ${TARGET_NAME}")
    else()
        log_option_disabled("Build unity")
    endif()

    if(ENABLE_TEST_LTO OR NOT TARGET crystalserver_testlib)
        configure_linking(${TARGET_NAME})
    else()
        set_property(TARGET ${TARGET_NAME} PROPERTY INTERPROCEDURAL_OPTIMIZATION FALSE)
    endif()

    add_test(NAME ${DIR} COMMAND ${TARGET_NAME})
    if(RUN_TESTS_AFTER_BUILD)
        add_custom_command(
                TARGET ${TARGET_NAME} POST_BUILD
                COMMAND ${CMAKE_CTEST_COMMAND} --verbose
                COMMENT "Running ctest ${DIR} after building ${TARGET_NAME}"
                WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/tests/${DIR}
        )
    endif (RUN_TESTS_AFTER_BUILD)
endfunction()

add_subdirectory(unit)
add_subdirectory(integration)