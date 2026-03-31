# vim:set sw=2 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

# Based on `Platform/Windows-MSVC.cmake` and Pelles C `.ppj` templates
include_guard ()

macro (__compiler_pellesc lang)
  # CMAKE_${lang}_COMPILE_OPTIONS_WARNING_AS_ERROR, don't have

  set(CMAKE_${lang}_LINK_MODE LINKER)
endmacro ()
