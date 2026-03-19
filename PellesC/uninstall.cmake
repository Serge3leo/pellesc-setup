# vim:set sw=4 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

file(REAL_PATH "_ids_.cmake" ids BASE_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}")
include(${ids})

message("uninstall: CMAKE_ROOT=${CMAKE_ROOT}")
set(p_idm "${CMAKE_ROOT}/Modules/CMakeCompilerIdDetection.cmake")
file(READ "${p_idm}" idm)

string(REGEX REPLACE
       "(\n[ \t]+${ID_PREV}[ \t]*\n).*#.*patch.*\n([ \t]+${ID_NEXT}[ \t]*\n)"
       "\\1\\2"
       idm_n "${idm}")
string(FIND "${idm_n}" "${ID_PELLESC}" c_pellesc)
if (NOT (NOT idm STREQUAL idm_n AND
         -1 EQUAL c_pellesc))
    message(FATAL_ERROR "Can't uninstall ${ID_PELLESC} modules: '${p_idm}'")
endif ()

set(p_adm "${CMAKE_ROOT}/Modules/CMakeDetermineASMCompiler.cmake")
file(READ "${p_adm}" adm)

string(REGEX REPLACE
    "(\n[ \t]+${ASM_PREV}[ \t]*\n).*#.*patch.*\n([ \t]+${ASM_NEXT}[ \t]*\n)"
       "\\1\\2"
       adm_n "${adm}")
if ("${adm}" STREQUAL "${adm_n}")
    message(FATAL_ERROR "Can't uninstall ${ID_PELLESC} modules: '${p_adm}'")
endif ()

file(RENAME "${p_idm}" "${p_idm}.pre-uninstall")
file(WRITE "${p_idm}" "${idm_n}")
file(RENAME "${p_adm}" "${p_adm}.pre-uninstall")
file(WRITE "${p_adm}" "${adm_n}")

file(GLOB_RECURSE ufs LIST_DIRECTORIES false
     "${CMAKE_ROOT}/Modules/*${ID_PELLESC}*.cmake")
foreach (f IN LISTS ufs)
    message("${f}")
    file(REMOVE "${f}")
endforeach ()
message("uninstall: from ${p_idm} and ${p_adm}")
