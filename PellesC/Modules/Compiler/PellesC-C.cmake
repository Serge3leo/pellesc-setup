# vim:set sw=2 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

# TODO set(_id_pellesc_ "PellesC")
# TODO message("PellesC-C: CMAKE_ROOT=${CMAKE_ROOT}")

include(Compiler/CMakeCommonCompilerMacros)
include(Compiler/PellesC)
__compiler_pellesc(C)

set(CMAKE_C_OUTPUT_EXTENSION ".obj")
set(CMAKE_C_VERBOSE_FLAG "-V2")

set(CMAKE_C99_STANDARD_COMPILE_OPTION -std=c99)
set(CMAKE_C99_EXTENSION_COMPILE_OPTION -Ze -Zx -std=c99)
set(CMAKE_C99_STANDARD__HAS_FULL_SUPPORT ON)
set(CMAKE_C11_STANDARD_COMPILE_OPTION -std=c11)
set(CMAKE_C11_EXTENSION_COMPILE_OPTION -Ze -Zx -std=c11)
set(CMAKE_C11_STANDARD__HAS_FULL_SUPPORT ON)
set(CMAKE_C17_STANDARD_COMPILE_OPTION -std=c17)
set(CMAKE_C17_EXTENSION_COMPILE_OPTION -Ze -Zx -std=c17)

set(CMAKE_C_STANDARD_LATEST 17)

if (CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL 12.0)
  set(CMAKE_C23_STANDARD_COMPILE_OPTION -std=c23)
  set(CMAKE_C23_EXTENSION_COMPILE_OPTION -Ze -Zx -std=c23)

  set(CMAKE_C_STANDARD_LATEST 23)
elseif (CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL 11.0)
  # PellesC 11.00.3 имеет `-std=c2x`, но `__STDC_VERSION__=202912L`
  # TODO непонятно, почему не получилось объявить для него крайним 17 (cmake
  # version 4.2.3)

  set(CMAKE_C23_STANDARD_COMPILE_OPTION -std=c2x)
  set(CMAKE_C23_EXTENSION_COMPILE_OPTION -Ze -Zx -std=c2x)

  set(CMAKE_C_STANDARD_LATEST 23)
endif ()

__compiler_check_default_language_standard(C 9.0 17 12.0 23)
