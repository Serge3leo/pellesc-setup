# vim:set sw=4 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

file(REAL_PATH "_ids_.cmake" ids BASE_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}")
include(${ids})

message("detect: CMAKE_ROOT=${CMAKE_ROOT}")
file(READ ${CMAKE_ROOT}/Modules/CMakeCompilerIdDetection.cmake idm)
if (NOT idm MATCHES "\n[ \t]+${ID_PELLESC}[ \t]*\n")
    message("Don't detect ID_PELLESC='${ID_PELLESC}'")
    cmake_language(EXIT 1)
endif ()
message("Ok, detect ID_PELLESC='${ID_PELLESC}'")
cmake_language(EXIT 0)
