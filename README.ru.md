[![CMake on multiple platforms](https://github.com/Serge3leo/pellesc-msys2/actions/workflows/cmake-multi-platform.yml/badge.svg?branch=main)](https://github.com/Serge3leo/pellesc-msys2/actions/workflows/cmake-multi-platform.yml)

# pellesc-msys2
Устанавливает компилятор Pelles C и настраивает пути и переменные для
возможности использования CMake генератора "MSYS Makefiles" совместно с
[MSYS2](https://github.com/marketplace/actions/setup-msys2).

Поддерживается явное указание `-DCMAKE_C_COMPILER=pocc`, предпочтительно.  Так
же возможно задание `cc` или автоматическое определение, но ограничено,
смотрите ниже.

Смотрите так же [CMake модули поддержки Pells C](PellesC/README.ru.md).

## ПРЕДУПРЕЖДЕНИЕ
Команда `cc` имеет ограничения:
- Ошибки, в случае если `cc` вызывается по пути, который имеет пробелы;
- Версия `11.0.2`, не совместима с Windows 2022/2025;

Подробности смотрите [Test Pelles C](
https://github.com/Serge3leo/test-pellesc/blob/main/.github/workflows/test-pellesc.yml).

Если необходимо CMake автоопределение компилятора `cc`, для её обхода можно
использовать два варианта:
1. Установку Pelles C в каталог без пробелов в пути (параметр
   [location](#location)).  Используется по умолчанию;
2. Установку переменных окружения в форме SFN (Short File Names, параметр
   [env-workaround](#env-workaround).  Зависит от версии CMake.

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
## cache
  - Тип: `boolean`
  - Значение по умолчанию: `true`

Для ускорения повторного использования, кэшировать `MSYS2` и каталог установки
Pelles C.

## cmake-module
  - Тип: `string`
  - Допустимые значения: `check | always | not`
  - Значение по умолчанию: `check`

### always
Всегда устанавливать модули поддержки Pelles C.

### check
Проверить наличие.  Устанавливать модули поддержки Pelles C, если их нет.

### no
Не устанавливать модули поддержки Pelles C.

## env-workaround
  - Тип: `boolean`
  - Значение по умолчанию: `false`

Преобразовать переменные окружения в форму SFN, т.е. при значении
[location](#location) `c:\pellesc` они останутся неизменными, а при значении
`location` `C:\Program Files\PellesC` все вхождения будут заменены на
`C:\PROGRA~1\PellesC` (цифра может изменяться в зависимости от конкретной
установки).

## location
  - Тип: string
  - Допустимые значения: имя каталога или пустая строка
  - Значение по умолчанию: `c:\pellesc`

Если явно задано пустым, то каталог установки задаётся программой установки
Pelles C, для существующих версий `C:\Program Files\PellesC`.

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
(13.01, 23 Дек 2025, [https://www.pellesc.se](https://www.pellesc.se)), которой
нет у Chocolatey Community).  Иначе будет установлена указанная версия.  Список
доступных версии приведён:
[https://community.chocolatey.org/packages/pelles-c](https://community.chocolatey.org/packages/pelles-c).

# Участие
Замечания (issues), добавления или исправления (pr) - принимаются и
приветствуются.

# Лицензия
[BSD-2-Clause © 2025 Сергей Леонтьев (leo@sai.msu.ru).](LICENSE)
