# vim:set sw=2 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

set(_id_pellesc_ "PellesC")
message("PellesC-DetermineCompiler: CMAKE_ROOT=${CMAKE_ROOT}")

set(_compiler_id_pp_test "defined(__POCC__)")

set(_compiler_id_version_compute "
# define @PREFIX@COMPILER_VERSION_MAJOR @MACRO_DEC@(__POCC__/100)
# define @PREFIX@COMPILER_VERSION_MINOR @MACRO_DEC@(__POCC__%100)")
