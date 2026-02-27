# vim:set sw=4 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

set(id_pellesc "PellesC")
message("detect: CMAKE_ROOT=${CMAKE_ROOT}")
file(READ ${CMAKE_ROOT}/Modules/CMakeCompilerIdDetection.cmake idm)
if (NOT idm MATCHES "\n[ \t]+${id_pellesc}[ \t]*\n")
    message("FAIL, Don't detect id_pellesc='${id_pellesc}'")
    cmake_language(EXIT 1)
endif ()
message("Ok, detect id_pellesc='${id_pellesc}'")
cmake_language(EXIT 0)
