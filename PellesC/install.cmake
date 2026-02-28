# vim:set sw=4 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

set(_id_pellesc_ "PellesC")
set(id_prev "TinyCC")
set(id_next "Bruce")
set(id_msvc "MSVC")

message("install: CMAKE_ROOT=${CMAKE_ROOT}")
set(p_idm "${CMAKE_ROOT}/Modules/CMakeCompilerIdDetection.cmake")
file(READ "${p_idm}" idm)

string(REGEX REPLACE
       "(\n[ \t]+${id_prev}[ \t]*\n)([ \t]+${id_next}[ \t]*\n)"
       "\\1        # pellesc-msys2 patch\n        ${_id_pellesc_}\n\\2"
       idm_n "${idm}")
string(REGEX MATCHALL "\n[ \t]+(${_id_pellesc_})*\n" m_pellesc "${idm_n}")
string(STRIP "${m_pellesc}" m_pellesc)
string(REGEX MATCHALL "\n[ \t]+(${id_msvc})*\n" m_msvc "${idm_n}")
string(STRIP "${m_msvc}" m_msvc)
string(FIND "${idm_n}" "${_id_pellesc_}" c_pellesc)
string(FIND "${idm_n}" "${id_msvc}" c_msvc)
if (NOT (NOT idm STREQUAL idm_n AND
         _id_pellesc_ STREQUAL m_pellesc AND
         id_msvc STREQUAL m_msvc AND
         c_pellesc LESS c_msvc))
    message(FATAL_ERROR "Can't install ${_id_pellesc_} modules")
endif ()

file(GLOB_RECURSE ifs LIST_DIRECTORIES false
     RELATIVE "${CMAKE_SOURCE_DIR}/PellesC"
     "PellesC/Modules/*.cmake")
foreach (f IN LISTS ifs)
    message("${f}")
    file(COPY_FILE "PellesC/${f}" "${CMAKE_ROOT}/${f}")
endforeach ()

file(RENAME "${p_idm}" "${p_idm}.pre-install")
file(WRITE "${p_idm}" "${idm_n}")
message("install: to ${p_idm}")
