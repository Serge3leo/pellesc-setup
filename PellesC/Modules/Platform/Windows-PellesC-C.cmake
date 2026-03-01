# vim:set sw=2 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

# set(_id_pellesc_ "PellesC")
# message("Windows-PellesC-C: CMAKE_ROOT=${CMAKE_ROOT}")

set(CMAKE_LINK_LIBRARY_SUFFIX "")
set(CMAKE_STATIC_LIBRARY_SUFFIX ".lib")
set(CMAKE_IMPORT_LIBRARY_SUFFIX ".lib")
set(CMAKE_FIND_LIBRARY_PREFIXES "")
set(CMAKE_FIND_LIBRARY_SUFFIXES ".a" ".lib")

# PellesC don't have key for use WinMain()
# set(CMAKE_C_CREATE_WIN32_EXE "")  # generate a WIN32 gui program
set(CMAKE_C_CREATE_CONSOLE_EXE "")  # generate a WIN32 console program
