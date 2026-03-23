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
add_subdirectory(tests)
enable_testing()
