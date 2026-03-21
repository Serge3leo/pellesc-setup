@if "x%VERBOSE%"=="x" echo off
rem vim:set sw=4 ts=8 et fileencoding=utf8:
rem SPDX-License-Identifier: BSD-2-Clause
rem SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)

set build_type=Release
set build_output_dir=build\win_pocc
cmake -B %build_output_dir% ^
        -DCMAKE_C_COMPILER=pocc ^
        -DCMAKE_BUILD_TYPE=%build_type% ^
        -G "MSYS Makefiles" ^
        -S .
if errorlevel 1 exit /b
cmake --build %build_output_dir% --config %build_type%
if errorlevel 1 exit /b
ctest --output-on-failure --build-config %build_type% ^
      --test-dir %build_output_dir%
if errorlevel 1 exit /b
%build_output_dir%\hello
if errorlevel 1 exit /b
