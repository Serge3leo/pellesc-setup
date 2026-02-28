# vim:set sw=4 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

set(_id_pellesc_ "PellesC")
message("detect: CMAKE_ROOT=${CMAKE_ROOT}")
file(READ ${CMAKE_ROOT}/Modules/CMakeCompilerIdDetection.cmake idm)
if (NOT idm MATCHES "\n[ \t]+${_id_pellesc_}[ \t]*\n")
    message("FAIL, Don't detect _id_pellesc_='${_id_pellesc_}'")
    cmake_language(EXIT 1)
endif ()
message("Ok, detect _id_pellesc_='${_id_pellesc_}'")
cmake_language(EXIT 0)
