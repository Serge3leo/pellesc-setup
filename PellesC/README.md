<!-- vim:set sw=4 ts=8 fileencoding=utf8:
 SPDX-License-Identifier: BSD-2-Clause
 SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)
 -->

# CMake compiler and detections modules for Pells C
The installation requires permissions to create and modify files in the
subdirectories `CMAKE_ROOT` of the current CMake.

# Usage
## Install
```
cmake -P PellesC\install.cmake
```

If not registered.  Copy modules to `CMAKE_ROOT` and register Pelles C.

## Uninstall
```
cmake -P PellesC\uninstall.cmake
```

Deregister Pelles C and remove modules from `CMAKE_ROOT`.

## Check status
```
cmake -P PellesC\detect.cmake
```

Check registration Pelles C for current CMake.

# Links
- Discourse: [Contribution to the Pelles C Module](
  https://discourse.cmake.org/t/contribution-to-the-pelles-c-module/2268);
- Issue #21536: [Pelles C toolchain support](
  https://gitlab.kitware.com/cmake/cmake/-/issues/21536)

# Disclaimer
Sorry for my best English.  Alas, this file is actually a yandex translation of
[README.ru.md](README.ru.md) with minimal editorial changes.
