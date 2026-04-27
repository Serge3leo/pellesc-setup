# vim:set sw=4 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

list(INSERT CMAKE_MODULE_PATH 0 "${CMAKE_CURRENT_LIST_DIR}")
include(_patches_)

message("detect: CMAKE_ROOT=${CMAKE_ROOT}")
set(fail 0)
ps_detect(IdDetection "${IdDetection_detect}" fail)
ps_detect(DetermineASM "${DetermineASM_detect}" fail)
ps_detect(DetermineASM1 "${DetermineASM1_detect}" fail)
ps_detect(FindBinUtils "${FindBinUtils_detect}" fail)
if (fail)
    cmake_language(EXIT 1)
endif ()
message("Ok, detect IdDetection, DetermineASM, FindBinUtils")
cmake_language(EXIT 0)
