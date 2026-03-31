# vim:set sw=2 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

# Based on `Platform/Windows-MSVC.cmake` and Pelles C `.ppj` templates

include (Compiler/CMakeCommonCompilerMacros)
include (Compiler/PellesC)
__compiler_pellesc(C)

set(CMAKE_C_OUTPUT_EXTENSION ".obj")
set(CMAKE_C_VERBOSE_FLAG "-V2")

set(CMAKE_C99_STANDARD_COMPILE_OPTION -std=c99)
set(CMAKE_C99_EXTENSION_COMPILE_OPTION -D__STDC__=1 -D__STDC_VERSION__=199901L -Ze -Zx -std=c99)
set(CMAKE_C99_STANDARD__HAS_FULL_SUPPORT ON)
set(CMAKE_C11_STANDARD_COMPILE_OPTION -std=c11)
set(CMAKE_C11_EXTENSION_COMPILE_OPTION -D__STDC__=1 -D__STDC_VERSION__=201112L -Ze -Zx -std=c11)
set(CMAKE_C11_STANDARD__HAS_FULL_SUPPORT ON)
set(CMAKE_C17_STANDARD_COMPILE_OPTION -std=c17)
set(CMAKE_C17_EXTENSION_COMPILE_OPTION -D__STDC__=1 -D__STDC_VERSION__=201710L -Ze -Zx -std=c17)

set(CMAKE_C_STANDARD_LATEST 17)

if (CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL 12.0)
  set(CMAKE_C23_STANDARD_COMPILE_OPTION -std=c23)
  set(CMAKE_C23_EXTENSION_COMPILE_OPTION -D__STDC__=1 -D__STDC_VERSION__=202311L -Ze -Zx -std=c23)

  set(CMAKE_C_STANDARD_LATEST 23)
elseif (CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL 11.0)
  # PellesC 11.00.3 has `-std=c2x`, but `__STDC_VERSION__=202912L`
  # By docs `-std=c17` is default, but `__STDC_VERSION__=202912L` without
  # arguments.

  set(CMAKE_C_STANDARD_COMPUTED_DEFAULT 11)  # Force explicit setting
  message(VERBOSE "PellesC-C: Corrected CMAKE_C_STANDARD_COMPUTED_DEFAULT=${CMAKE_C_STANDARD_COMPUTED_DEFAULT}")

  set(CMAKE_C23_STANDARD_COMPILE_OPTION -std=c2x)
  set(CMAKE_C23_EXTENSION_COMPILE_OPTION -D__STDC__=1 -D__STDC_VERSION__=202912L -Ze -Zx -std=c2x)

  set(CMAKE_C_STANDARD_LATEST 23)
endif ()

message(VERBOSE "PellesC-C: input: CMAKE_C_EXTENSIONS_COMPUTED_DEFAULT=${CMAKE_C_EXTENSIONS_COMPUTED_DEFAULT}")
message(VERBOSE "PellesC-C: input: CMAKE_C_EXTENSIONS_DEFAULT=${CMAKE_C_EXTENSIONS_DEFAULT}")
message(VERBOSE "PellesC-C: input: CMAKE_C_EXTENSIONS=${CMAKE_C_EXTENSIONS}")
__compiler_check_default_language_standard(C 9.0 17 12.0 23)

message(VERBOSE "PellesC-C: check: CMAKE_C_EXTENSIONS_COMPUTED_DEFAULT=${CMAKE_C_EXTENSIONS_COMPUTED_DEFAULT}")
message(VERBOSE "PellesC-C: check: CMAKE_C_EXTENSIONS_DEFAULT=${CMAKE_C_EXTENSIONS_DEFAULT}")
message(VERBOSE "PellesC-C: check: CMAKE_C_EXTENSIONS=${CMAKE_C_EXTENSIONS}")
if (NOT DEFINED CMAKE_C_EXTENSIONS)
  # Conflict with RunCMake.try_compile, need disable CMP0067

  # FIXME: I don't understand CMP0128.  CMAKE_C_EXTENSIONS_DEFAULT
  # (CMAKE_C_EXTENSIONS_COMPUTED_DEFAULT) - describe the default behavior of
  # the compiler, without flags.  For PellesC - must be OFF.

  # But Test/RunCMake have `#include <windows.h>` without property C_EXTENSIONS.
  # `GenerateExportHeader` use `__declspec()` without property C_EXTENSIONS.

  # Now the behavior is similar to Clang/GNU.  If the user has not set the
  # property C_EXTENSIONS=OFF, all extensions are enabled.

  if (NOT DEFINED CMAKE_C_STANDARD)
    set(CMAKE_C_STANDARD "${CMAKE_C_STANDARD_DEFAULT}")
  endif ()
  set(CMAKE_C_EXTENSIONS ON)
endif ()

message(VERBOSE "PellesC-C: reset: CMAKE_C_EXTENSIONS_COMPUTED_DEFAULT=${CMAKE_C_EXTENSIONS_COMPUTED_DEFAULT}")
message(VERBOSE "PellesC-C: reset: CMAKE_C_EXTENSIONS_DEFAULT=${CMAKE_C_EXTENSIONS_DEFAULT}")
message(VERBOSE "PellesC-C: reset: CMAKE_C_EXTENSIONS=${CMAKE_C_EXTENSIONS}")
