# vim:set sw=2 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

# TODO set(_id_pellesc_ "PellesC")
# TODO message("PellesC-C: CMAKE_ROOT=${CMAKE_ROOT}")

include(Compiler/CMakeCommonCompilerMacros)
include(Compiler/PellesC)

set(CMAKE_C_OUTPUT_EXTENSION ".obj")
set(CMAKE_C_VERBOSE_FLAG "-V2")

set(CMAKE_C99_STANDARD_COMPILE_OPTION "-std=c99")
set(CMAKE_C99_EXTENSION_COMPILE_OPTION "-Zx -std=c99")
set(CMAKE_C99_STANDARD__HAS_FULL_SUPPORT ON)
set(CMAKE_C11_STANDARD_COMPILE_OPTION "-std=c11")
set(CMAKE_C11_EXTENSION_COMPILE_OPTION "-Zx -std=c11")
set(CMAKE_C11_STANDARD__HAS_FULL_SUPPORT ON)
set(CMAKE_C17_STANDARD_COMPILE_OPTION "-std=c17")
set(CMAKE_C17_EXTENSION_COMPILE_OPTION "-Zx -std=c17")
set(CMAKE_C23_STANDARD_COMPILE_OPTION "-std=c23")
set(CMAKE_C23_EXTENSION_COMPILE_OPTION "-Zx -std=c23")

set(CMAKE_C_STANDARD_LATEST 23)

__compiler_check_default_language_standard(C 9.0 17 12.0 23)  # TODO check 12.0
__compiler_pellesc(C)
