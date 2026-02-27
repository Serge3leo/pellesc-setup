# vim:set sw=4 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2025 Сергей Леонтьев (leo@sai.msu.ru)

set(PellesC_ID "PellesC")
message("CMAKE_ROOT=${CMAKE_ROOT}")
file(READ ${CMAKE_ROOT}/Modules/CMakeCompilerIdDetection.cmake idm)
if (NOT idm MATCHES "\n[ \t]+${PellesC_ID}[ \t]*\n")
    message("FAIL, Don't detect PellesC_ID='${PellesC_ID}'")
    cmake_language(EXIT 1)
endif ()
message("Ok, detect PellesC_ID='${PellesC_ID}'")
cmake_language(EXIT 0)
