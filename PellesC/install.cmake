# vim:set sw=4 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

file(REAL_PATH "_ids_.cmake" ids BASE_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}")
include(${ids})

message("install: CMAKE_ROOT=${CMAKE_ROOT}")
set(p_idm "${CMAKE_ROOT}/Modules/CMakeCompilerIdDetection.cmake")
file(READ "${p_idm}" idm)

string(REGEX REPLACE
    "(\n[ \t]+${ID_PREV}[ \t]*\n)([ \t]+${ID_NEXT}[ \t]*\n)"
       "\\1        # pellesc-msys2 patch\n        ${ID_PELLESC}\n\\2"
       idm_n "${idm}")
string(REGEX MATCHALL "\n[ \t]+(${ID_PELLESC})[ \t]*\n" m_pellesc "${idm_n}")
string(STRIP "${m_pellesc}" m_pellesc)
string(REGEX MATCHALL "\n[ \t]+(${ID_LATER})[ \t]*\n" m_msvc "${idm_n}")
string(STRIP "${m_msvc}" m_msvc)
string(FIND "${idm_n}" "${ID_PELLESC}" c_pellesc)
string(FIND "${idm_n}" "${ID_LATER}" c_msvc)
if (NOT (NOT idm STREQUAL idm_n AND
         ID_PELLESC STREQUAL m_pellesc AND
         ID_LATER STREQUAL m_msvc AND
         c_pellesc LESS c_msvc))
    message(FATAL_ERROR "Can't install ${ID_PELLESC} modules")
endif ()

file(GLOB_RECURSE ifs LIST_DIRECTORIES false
     RELATIVE "${CMAKE_CURRENT_LIST_DIR}"
     "${CMAKE_CURRENT_LIST_DIR}/Modules/*${ID_PELLESC}*.cmake")
foreach (f IN LISTS ifs)
    message("${f}")
    file(COPY_FILE "${CMAKE_CURRENT_LIST_DIR}/${f}" "${CMAKE_ROOT}/${f}")
endforeach ()

file(RENAME "${p_idm}" "${p_idm}.pre-install")
file(WRITE "${p_idm}" "${idm_n}")
message("install: to ${p_idm}")
