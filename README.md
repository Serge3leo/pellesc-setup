[![CMake on multiple platforms](https://github.com/Serge3leo/pellesc-msys2/actions/workflows/cmake-multi-platform.yml/badge.svg?branch=main)](https://github.com/Serge3leo/pellesc-msys2/actions/workflows/cmake-multi-platform.yml)

# pellesc-setup
Installs the Pelles C compiler and configures paths and environment variables
for the possibility of using the CMake.

Explicit indication of `-DCMAKE_C_COMPILER=pocc` is supported, preferably.  It
is also possible to set `cc` or automatic detection, but limited, see below.

See also [CMake compiler and detections modules for Pells C](
PellesC/README.md).

## WARNING
Chocolatey repository versions `12.0.2` (pocc 12.00.1) and `11.0.2` (pocc
11.00.3) work with CMake seems to be working only under Windows 2022.

The `cc` command has limitations:
- Bugs if `cc` is called on a path that has spaces;
- Version `11.0.2', not compatible with Windows 2022/2025;

For details, see [Test Pelles C](
https://github.com/Serge3leo/test-pellesc/blob/main/.github/workflows/test-pellesc.yml).

If you need CMake to autodetect the `cc` compiler, you can use two options to
workaround it:
1. Install Pelles C in a directory without spaces in the path (parameter
   [location](#location)).  This is the default option.
2. Set environment variables in SFN (Short File Names) format (parameter
   [env-workaround](#env-workaround)).  This option depends on the CMake
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
  - [Learn CMake on GitHub multiple platforms](
    https://github.com/Serge3leo/learn-cmake/blob/main/.github/workflows/learn_cmake.yml);
  - [cmake-multi-platform.yml](.github/workflows/cmake-multi-platform.yml);
  - [C23/C++14 platform independent implementation of C2y countof()](
    https://github.com/Serge3leo/countof_ns/blob/main/.github/workflows/cmake-multi-platform.yml).

# Options
## cache
  - Type: `boolean`
  - Default: `true`

To speed up re-use, cache installation directory Pelles C.

It may be useful to use additional workflows to delete caches that are unlikely
to be used (after a PR is closed, etc.).  Templates for such workflows: [Clean
Cache Action]( https://github.com/marketplace/actions/clean-cache) or
https://github.com/marketplace/actions/clean-cache-action .

## cmake
  - Type: `string`
  - Allowed values: executable command (path) `cmake`
  - Default value: `cmake`

Sets the `cmake` command used when installing support modules (i.e.
after installation, this particular `cmake` command will support the Pelles
C compiler).

## cmake-module
  - Type: `string`
  - Allowed values: `check | always | not`
  - Default: `check`

### always
Always install the Pelles C support modules.

### check
Check the Pelles C support modules.  Install the Pelles C support modules if
they are not present in `PellesC`.

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

## key-prefix
  - Type: `string`

Add prefix to cache key (for refresh version, identification etc).

## location
  - Type: `string`
  - Allowed values: directory name or an empty string
  - Default: `c:\pellesc`

If explicitly set to empty, the installation directory is set by the
installation program Pelles C, for existing versions `C:\Program
Files\PellesC`.

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
If you explicitly set an empty value, the latest version from Chocolatey
Community will be installed.  The list of available versions is given below:
[https://community.chocolatey.org/packages/pelles-c](https://community.chocolatey.org/packages/pelles-c).

# Outputs

If the `cmake-module` parameter was not equal to `no`:

- CMAKE_ROOT - The full path to the PellesC module installation directory;
- CMAKE_COMMAND - The full path to the `cmake` command.

# Contributing
Issues or PRs are accepted and welcome.

# Disclaimer
Sorry for my best English.  Alas, this file is actually a yandex translation of
[README.ru.md](README.ru.md) with minimal editorial changes.

# License
[BSD-2-Clause © 2026 Сергей Леонтьев (leo@sai.msu.ru).](LICENSE)
