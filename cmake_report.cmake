# vim:set sw=4 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

cmake_path(NATIVE_PATH CMAKE_COMMAND cm_command)
message("CMAKE_COMMAND=${cm_command}")
cmake_path(NATIVE_PATH CMAKE_ROOT cm_path)
message("CMAKE_ROOT=${cm_path}")
