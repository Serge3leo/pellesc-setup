# vim:set sw=2 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

# Based on `Platform/Windows-MSVC.cmake` and Pelles C `.ppj` templates

include (Platform/Windows-PellesC)
__windows_compiler_pellesc(ASM)

set(CMAKE_ASM_SOURCE_FILE_EXTENSIONS s;S;asm)
