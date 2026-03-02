[![CMake on multiple platforms](https://github.com/Serge3leo/pellesc-msys2/actions/workflows/cmake-multi-platform.yml/badge.svg)](https://github.com/Serge3leo/pellesc-msys2/actions/workflows/cmake-multi-platform.yml)

# pellesc-msys2
Устанавливает компилятор Pelles C и настраивает пути и переменные для
возможности использования CMake генератора "MSYS Makefiles" совместно с
предустановленным в образе MSYS2.

## ПРЕДУПРЕЖДЕНИЕ
Команда `cc` имеет ошибку, в случае если она вызывается с явным указанием пути,
который имеет пробелы. Поэтому CMake не может её использовать, работает только
явное указание `cmake ... -DCMAKE_C_COMPILER=pocc ...`. Пример возникновения
этой ошибки смотрите шаг `Check workaround Pelles C long name bug`
[cmake-multi-platform.yml](.github/workflows/cmake-multi-platform.yml).

Для её обхода необходимо:
1. Использовать пути без пробелов, например Short File Name (SFN,
   `C:\PROGRA~1\PellesC\Bin`);
2. Обновить версию CMake, параметр `cmake-update: true`, смотрите ниже.

# Использование
```
  - uses: Serge3leo/pellesc-msys2@v0
```

или

```
  - uses: Serge3leo/pellesc-msys2@v0
    with:
      version: 12.0.2
      verbose: true
```

Пример совместного использование в проекте CMake можно увидеть:
  - [cmake-multi-platform.yml](.github/workflows/cmake-multi-platform.yml);
  - [C23/C++14 platform independent implementation of C2y countof()](
    https://github.com/Serge3leo/countof_ns/blob/main/.github/workflows/cmake-multi-platform.yml).

# Параметры
## cmake-module
  - Тип: `string`
  - Допустимые значения: `check | always | not`
  - Значение по умолчанию: `check`

### always
Всегда устанавливать модули поддержки Pelles C.

### check
Проверить переменную `CMAKE_C_COMPILER_LIST`.  Устанавливать модули поддержки
Pelles C, если эта переменная не содержит `PellesC`.

### no
Не устанавливать модули поддержки Pelles C.

## cmake-update
  - Тип: `boolean`
  - Значение по умолчанию: `false`

Обновить версию CMake из репозитория Chocolatey Software, Inc. до последней
доступной.

## msystem
  - Тип: string
  - Допустимые значения: `msys | mingw64 | mingw32 | ucrt64 | clang64 |
    clangarm64 | skip`
  - Значение по умолчанию: `mingw64`

Задаёт значение переменной окружения [`MSYSTEM`](
https://www.msys2.org/docs/environments) и `PATH`.  Регистр игнорируется.  Если
равно `skip`, то настройка MSYS2 пропускается.

## verbose
  - Тип: `boolean`
  - Значение по умолчанию: `false`

Печатает пути и версии основных компонент: `pocc`, `make`, `cmake`, ...

## version
  - Тип: `string`
  - Значение по умолчанию: `13.01-git-lfs`

Если не задан, устанавливается версия `13.01-git-lfs` из этого репозитория
(13.01, 23 дек 2025 [https://www.pellesc.se](https://www.pellesc.se), которой
нет у Chocolatey Community).  Иначе будет установлена указанная версия.  Список
доступных версии приведён:
[https://community.chocolatey.org/packages/pelles-c](https://community.chocolatey.org/packages/pelles-c).

# Участие
Замечания (issues), добавления или исправления (pr) - принимаются и
приветствуются.

# Лицензия
[BSD-2-Clause © 2025 Сергей Леонтьев (leo@sai.msu.ru).](LICENSE)
