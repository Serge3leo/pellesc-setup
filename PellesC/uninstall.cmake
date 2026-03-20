# vim:set sw=4 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

list(INSERT CMAKE_MODULE_PATH 0 "${CMAKE_CURRENT_LIST_DIR}")
include(_patches_)

message("uninstall: CMAKE_ROOT=${CMAKE_ROOT}")
file(READ "${CMAKE_ROOT}/Modules/${IdDetection_module}" idm)
file(READ "${CMAKE_ROOT}/Modules/${DetermineASM_module}" adm)
set(fail 0)
ps_rev_apply_patch("${adm}" DetermineASM adm_n fail)
ps_rev_apply_patch("${idm}" IdDetection idm_n fail)
if (fail)
    message(FATAL_ERROR "Can't uninstall all patches")
endif ()
ps_save("${CMAKE_ROOT}/Modules/${IdDetection_module}" "pre-uninstall" "${idm_n}")
ps_save("${CMAKE_ROOT}/Modules/${DetermineASM_module}" "pre-uninstall" "${adm_n}")
ps_uninstall("${CMAKE_CURRENT_LIST_DIR}/Modules")
