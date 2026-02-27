[![CMake on multiple platforms](https://github.com/Serge3leo/pellesc-msys2/actions/workflows/cmake-multi-platform.yml/badge.svg)](https://github.com/Serge3leo/pellesc-msys2/actions/workflows/cmake-multi-platform.yml)

# pellesc-msys2
Installs the Pelles C compiler and configures paths and environment variables
for the possibility of using the CMake generator "MSYS Makefiles" with the
pre-installed MSYS2 image.

# Usage
```
  - uses: Serge3leo/pellesc-msys2@v0
```

or

```
  - uses: Serge3leo/pellesc-msys2@v0
    with:
      version: 12.0.2
      verbose: on
```

An example with a CMake project can be see:
  - [cmake-multi-platform.yml](.github/workflows/cmake-multi-platform.yml);
  - [C23/C++14 platform independent implementation of C2y countof()](
    https://github.com/Serge3leo/countof_ns/blob/main/.github/workflows/cmake-multi-platform.yml).

# Options
## version
  - Type: `string`

If not specified, version 13.01 from this repository is installed (Dec 23, 2025
[https://www.pellesc.se](https://www.pellesc.se), it not at Chocolatey
Community).  Otherwise, the specified version will be installed.  The list of
available versions is given below:
[https://community.chocolatey.org/packages/pelles-c](https://community.chocolatey.org/packages/pelles-c).

## verbose
  - Type: `boolean`
  - Default: `false`

Show the paths and versions of the main components: `pocc`, `make`, `cmake`, ...

## cmake-module
  - Type: `string`
  - Allowed values: `check | always | not`
  - Default: `check`

Check the variable `CMAKE_C_COMPILER_LIST`.  Install Pelles C support modules
if this variable do not contain `PellesC`.

# Contributing
Issues or PRs are accepted and welcome.

# Disclaimer
Sorry for my best English.  Alas, this file is actually a yandex translation of
[README.ru.md](README.ru.md) with minimal editorial changes.

# License
[BSD-2-Clause © 2025 Сергей Леонтьев (leo@sai.msu.ru).](LICENSE)
