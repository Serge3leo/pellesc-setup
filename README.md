[![CMake on multiple platforms](https://github.com/Serge3leo/pellesc-msys2/actions/workflows/cmake-multi-platform.yml/badge.svg)](https://github.com/Serge3leo/pellesc-msys2/actions/workflows/cmake-multi-platform.yml)

# pellesc-msys2
Installs the Pelles C compiler and configures paths and environment variables
for the possibility of using the CMake generator "MSYS Makefiles" with the
pre-installed MSYS2 image.

## WARNING
The `cc` command has an bug if it is called with an explicit path that contains
spaces. Therefore, CMake cannot use it, and only the explicit call `cmake ...
-DCMAKE_C_COMPILER=pocc ...` works. For an example of this error, see the step
`Check workaround Pelles C long name bug` in
[cmake-multi-platform.yml](.github/workflows/cmake-multi-platform.yml).

To workaround this error, you need to:
1. Use paths without spaces, such as Short File Name (SFN,
   `C:\PROGRA~1\PellesC\Bin`);
2. Update the CMake version using the `cmake-update: true` parameter, as
   described below.

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

## cmake-update
  - Type: `boolean`
  - Default: `false`

Update the version of CMake from the Chocolatey Software, Inc. repository to
the latest available version.

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
(13.01, Dec 23, 2025 [https://www.pellesc.se](https://www.pellesc.se), it not
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
