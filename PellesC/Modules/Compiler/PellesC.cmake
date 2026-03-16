# vim:set sw=2 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

# По мотивам Platform/Windows-MSVC.cmake
# И шаблонов `.ppj` PellesC

include_guard()

macro (__compiler_pellesc lang)
  # CMAKE_${lang}_COMPILE_OPTIONS_WARNING_AS_ERROR - нет

  set(CMAKE_${lang}_LINK_MODE LINKER)
endmacro ()
