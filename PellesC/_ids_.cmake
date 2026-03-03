# vim:set sw=4 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

include_guard()

file(GLOB ID_PELLESC
     "${CMAKE_CURRENT_LIST_DIR}/Modules/Compiler/*-DetermineCompiler.cmake")
if (NOT ${ID_PELLESC} MATCHES "/([^/-]+)-DetermineCompiler\\.cmake$")
    message(FATAL_ERROR "FAIL: _ids_: Invalid Id of Pelles C compiller")
endif ()
set(ID_PELLESC ${CMAKE_MATCH_1})

# Install (insert) ID_PELLESC between:
set(ID_PREV "TinyCC")
set(ID_NEXT "Bruce")

# ID_PELLESC must be before
set(ID_LATER "MSVC")
