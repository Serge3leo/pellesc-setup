# vim:set sw=4 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

add_compile_definitions(TEST_DEFINITIONS
    "TEST_DEFINITIONS_VAL=\\042Test_1917\\042")

add_executable(hello hello.c)
target_include_directories(hello PRIVATE first second)
add_test(NAME hello COMMAND hello)
set_tests_properties(hello PROPERTIES PASS_REGULAR_EXPRESSION
    "Привет мир.*TEST_DEFINITIONS=\n.*Include: Reverse order")

add_executable(simple_false simple_false.c)
add_test(NAME simple_false COMMAND simple_false)
set_tests_properties(simple_false PROPERTIES WILL_FAIL true)

add_executable(bsd_echo bsd_echo.c)
add_test(NAME bsd_echo COMMAND bsd_echo -n a b c)
set_tests_properties(bsd_echo PROPERTIES PASS_REGULAR_EXPRESSION "a b c")

add_executable(hello_INCLUDE hello.c)
set_target_properties(hello_INCLUDE PROPERTIES EXCLUDE_FROM_ALL TRUE)
message(VERBOSE "ENV{INCLUDE}=$ENV{INCLUDE}")
add_test(NAME hello_INCLUDE COMMAND "${CMAKE_COMMAND}" -E
         env "INCLUDE=$ENV{INCLUDE};${CMAKE_CURRENT_SOURCE_DIR}\\first;${CMAKE_CURRENT_SOURCE_DIR}\\second"
         "${CMAKE_CTEST_COMMAND}"
         --build-and-test "${CMAKE_SOURCE_DIR}"
                          "${CMAKE_BINARY_DIR}"
         --build-generator "${CMAKE_GENERATOR}"
         --build-makeprogram "${CMAKE_MAKE_PROGRAM}"
         --build-config "${CMAKE_BUILD_TYPE}"
         --build-nocmake
         --build-noclean
         --build-target hello_INCLUDE
         --test-command "${CMAKE_CURRENT_BINARY_DIR}/hello_INCLUDE")
set_tests_properties(hello_INCLUDE PROPERTIES PASS_REGULAR_EXPRESSION
    "Привет мир.*TEST_DEFINITIONS=\n.*Include: Forward order")

enable_testing()
