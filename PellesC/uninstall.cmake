# vim:set sw=4 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

set(id_pellesc "PellesC")
set(id_prev "TinyCC")
set(id_next "Bruce")

message("install: CMAKE_ROOT=${CMAKE_ROOT}")
set(p_idm "${CMAKE_ROOT}/Modules/CMakeCompilerIdDetection.cmake")
file(READ "${p_idm}" idm)

string(REGEX REPLACE
       "(\n[ \t]+${id_prev}[ \t]*\n).*#.*patch.*\n([ \t]+${id_next}[ \t]*\n)"
       "\\1\\2"
       idm_n "${idm}")
string(FIND "${idm_n}" "${id_pellesc}" c_pellesc)
if (NOT (NOT idm STREQUAL idm_n AND
         -1 EQUAL c_pellesc))
    message(FATAL_ERROR "Can't uninstall ${id_pellesc} modules")
endif ()

file(GLOB_RECURSE ufs LIST_DIRECTORIES false
     "${CMAKE_ROOT}/Modules/*${id_pellesc}*.cmake")
foreach (f IN LISTS ufs)
    message("${f}")
    file(REMOVE "${f}")
endforeach ()

file(RENAME "${p_idm}" "${p_idm}.pre-uninstall")
file(WRITE "${p_idm}" "${idm_n}")
message("uninstall: from ${p_idm}")
