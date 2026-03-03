[![CMake on multiple platforms](https://github.com/Serge3leo/pellesc-msys2/actions/workflows/cmake-multi-platform.yml/badge.svg)](https://github.com/Serge3leo/pellesc-msys2/actions/workflows/cmake-multi-platform.yml)

# pellesc-msys2
Installs the Pelles C compiler and configures paths and environment variables
for the possibility of using the CMake generator "MSYS Makefiles" in
conjunction with [MSYS2](https://github.com/marketplace/actions/setup-msys2).

Explicit indication of `-DCMAKE_C_COMPILER=pocc` is supported, preferably.  It
is also possible to set `cc` or automatic detection, but limited, see below.

See also [CMake compiler and detections modules for Pells C](
PellesC/README.md).

## WARNING
The `cc` command has limitations:
- Bugs if `cc` is called on a path that has spaces;
- Version `11.0.2', not compatible with Windows 2022/2025;

For details, see [Test Pelles C](
https://github.com/Serge3leo/test-pellesc/blob/main/.github/workflows/test-pellesc.yml).

If you need CMake to autodetect the `cc` compiler, you can use two options to
work around it:
1. Install Pelles C in a directory without spaces in the path (parameter
   [location](#location)). This is the default option.
2. Set environment variables in SFN (Short File Names) format (parameter
   [env-workaround](#env-workaround)). This option depends on the CMake
   version.

# Usage
```
  - uses: Serge3leo/pellesc-msys2@v0
```

or

```
  - uses: Serge3leo/pellesc-msys2@v0
    with:
      version: 12.0.2
      verbose: true
```

An example with a CMake project can be see:
  - [cmake-multi-platform.yml](.github/workflows/cmake-multi-platform.yml);
  - [C23/C++14 platform independent implementation of C2y countof()](
    https://github.com/Serge3leo/countof_ns/blob/main/.github/workflows/cmake-multi-platform.yml).

# Options
## cache
  - Type: `boolean`
  - Default: `false`

To speed up re-use, cache `MSYS2` and the installation directory Pelles C.

## cmake-module
  - Type: `string`
  - Allowed values: `check | always | not`
  - Default: `check`

### always
Always install the Pelles C support modules.

### check
Check the variable `CMAKE_C_COMPILER_LIST`.  Install Pelles C support modules
if this variable do not contain `PellesC`.

### no
Do not install Pelles C support modules.

## env-workaround
  - Type: `boolean`
  - Default: `false`

Convert the environment variables to SFN form, i.e. if the value is
[location](#location) `c:\pellesc`, they will remain unchanged, and if the
value is `location` `C:\Program Files\PellesC`, all occurrences will be
replaced with `C:\PROGRA~1\PellesC` (the number may vary depending on the
specific installation).

## location
  - Type: `string`
  - Allowed values: directory name or an empty string
  - Default: `c:\pellesc`

If explicitly set to empty, the installation directory is set by the
installation program Pelles C, for existing versions `C:\Program
Files\PellesC`.

## msystem
  - Type: `string`
  - Allowed values: `msys | mingw64 | mingw32 | ucrt64 |
    clang64 | clangarm64 | skip`
  - Default: `mingw64`

Sets the value of the environment variable [`MSYSTEM`](
https://www.msys2.org/docs/environments) and `PATH`.  Case is ignored.  If
equal to `skip`, then the MSYS2 configuration is skipped.

## verbose
  - Type: `boolean`
  - Default: `false`

Show the paths and versions of the main components: `pocc`, `make`, `cmake`, ...

## version
  - Type: `string`
  - Default: `13.01-git-lfs`

If not specified, version `13.01-git-lfs` from this repository is installed
(13.01, Dec 23, 2025, [https://www.pellesc.se](https://www.pellesc.se)), it not
at Chocolatey Community).  Otherwise, the specified version will be installed.
The list of available versions is given below:
[https://community.chocolatey.org/packages/pelles-c](https://community.chocolatey.org/packages/pelles-c).

# Contributing
Issues or PRs are accepted and welcome.

# Disclaimer
Sorry for my best English.  Alas, this file is actually a yandex translation of
[README.ru.md](README.ru.md) with minimal editorial changes.

# License
[BSD-2-Clause © 2025 Сергей Леонтьев (leo@sai.msu.ru).](LICENSE)
