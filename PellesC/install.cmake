# vim:set sw=4 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

list(INSERT CMAKE_MODULE_PATH 0 "${CMAKE_CURRENT_LIST_DIR}")
include(_patches_)

message("install: CMAKE_ROOT=${CMAKE_ROOT}")
file(READ "${CMAKE_ROOT}/Modules/${IdDetection_module}" idm)
file(READ "${CMAKE_ROOT}/Modules/${DetermineASM_module}" adm)
set(fail 0)
ps_apply_patch("${idm}" IdDetection idm_n fail)
ps_apply_patch("${adm}" DetermineASM adm_n fail)
string(FIND "${idm_n}" "${ID_PELLESC}" c_pellesc)
string(FIND "${idm_n}" "${ID_LATER}" c_msvc)
if (fail)
    message(FATAL_ERROR "Can't install all patches")
endif ()
if (c_pellesc GREATER_EQUAL c_msvc)
    message(FATAL_ERROR "${ID_PELLESC} must be before ${ID_LATER}")
endif ()
ps_install("${CMAKE_CURRENT_LIST_DIR}/Modules")
ps_save("${CMAKE_ROOT}/Modules/${DetermineASM_module}" "pre-install" "${adm_n}")
ps_save("${CMAKE_ROOT}/Modules/${IdDetection_module}" "pre-install" "${idm_n}")
