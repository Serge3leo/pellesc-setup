# vim:set sw=2 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

# TODO set(_id_pellesc_ "PellesC")
# TODO message("PellesC-DetermineCompiler: CMAKE_C_COMPILER=${CMAKE_C_COMPILER} CMAKE_ROOT=${CMAKE_ROOT}")

# Pelles C bug (TODO: ID & versions)
string(TOLOWER "${CMAKE_C_COMPILER}" _pellesc_lower_)
if ( "${_pellesc_lower_}" MATCHES " .*pelles *c.bin.cc")
  message("WARNING: PellesC have space in CMAKE_C_COMPILER=\"${CMAKE_C_COMPILER}\", use SFN: C:\\PROGRA~1\\PellesC\\Bin")
endif ()

set(_compiler_id_pp_test "defined(__POCC__)")

set(_compiler_id_version_compute "
# define @PREFIX@COMPILER_VERSION_MAJOR @MACRO_DEC@(__POCC__/100)
# define @PREFIX@COMPILER_VERSION_MINOR @MACRO_DEC@(__POCC__%100)")
