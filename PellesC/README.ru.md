<!-- vim:set sw=4 ts=8 fileencoding=utf8:
 SPDX-License-Identifier: BSD-2-Clause
 SPDX-FileCopyrightText: 2026 Сергей Леонтьев (leo@sai.msu.ru)
 -->

# CMake модули поддержки Pells C
Для установки требуются права на создание и модификацию файлов в подкаталогах
`CMAKE_ROOT` текущего CMake.

# Использование
## Установка
```
cmake -P PellesC\install.cmake
```

Если не зарегистрированы.  Копирует модули в `CMAKE_ROOT` и регистрирует Pelles
C.

## Удаление
```
cmake -P PellesC\uninstall.cmake
```

Снимает регистрацию Pelles C и удаляет модули `CMAKE_ROOT`.

## Статус
```
cmake -P PellesC\detect.cmake
```

Проверяет регистрацию Pelles C для текущего CMake.

## Известные особенности и ограничения

- Политика CMP0197 не реализована (32-бит не проверен).

#  Ссылки
- Discourse: [Contribution to the Pelles C Module](
  https://discourse.cmake.org/t/contribution-to-the-pelles-c-module/2268);
- Issue #21536: [Pelles C toolchain support](
  https://gitlab.kitware.com/cmake/cmake/-/issues/21536)
