# vim:set sw=4 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

cmake_minimum_required (VERSION 3.25)
project(pellesc_msys2
        VERSION 0.3.0
        DESCRIPTION
        "Use PellesC in CMake project"
        HOMEPAGE_URL https://github.com/Serge3leo/pellesc-msys2.git
        LANGUAGES C)

add_executable(hello hello.c)
target_compile_definitions(hello PRIVATE TEST_DEFINITIONS)
target_compile_definitions(hello PRIVATE TEST_DEFINITIONS_VAL=1917)
add_test(NAME hello COMMAND hello)
set_tests_properties(hello PROPERTIES PASS_REGULAR_EXPRESSION "Привет мир")

add_executable(simple_false simple_false.c)
add_test(NAME simple_false COMMAND simple_false)
set_tests_properties(simple_false PROPERTIES WILL_FAIL true)

add_executable(bsd_echo bsd_echo.c)
add_test(NAME bsd_echo COMMAND bsd_echo -n a b c)
set_tests_properties(bsd_echo PROPERTIES PASS_REGULAR_EXPRESSION "a b c")

enable_testing()
