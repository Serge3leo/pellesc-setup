# vim:set sw=4 ts=8 et fileencoding=utf8:
# SPDX-License-Identifier: BSD-2-Clause
# SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

cmake_minimum_required (VERSION 3.25)
project(pellesc_setup
        VERSION 0.6.0
        DESCRIPTION
        "Use PellesC in CMake project"
        HOMEPAGE_URL https://github.com/Serge3leo/pellesc-setup.git
        LANGUAGES C)
if (MINGW)
    message(FATAL_ERROR "PellesC - not MINGW")
elseif (NOT CMAKE_HOST_WIN32)
    message(FATAL_ERROR "PellesC - CMAKE_HOST_WIN32 only")
elseif (NOT WIN32)
    message(FATAL_ERROR "PellesC - CMAKE_HOST_WIN32 only")
elseif (NOT CMAKE_C_COMPILER_ID STREQUAL PellesC)
    message(FATAL_ERROR "PellesC - PellesC only")
endif ()
add_subdirectory(tests)
enable_testing()
