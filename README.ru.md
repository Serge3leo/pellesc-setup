[![CMake on multiple platforms](https://github.com/Serge3leo/pellesc-setup/actions/workflows/cmake-multi-platform.yml/badge.svg?branch=main)](https://github.com/Serge3leo/pellesc-setup/actions/workflows/cmake-multi-platform.yml)

# pellesc-setup
Устанавливает компилятор Pelles C и настраивает пути и переменные для
возможности использования CMake.

Предпочтительно использовать явное указание `cmake -DCMAKE_C_COMPILER=pocc`.
Так же возможно задание `cc` или автоматическое определение, но ограничено,
смотрите ниже.

Смотрите так же [CMake модули поддержки Pells C](PellesC/README.ru.md).

## ПРЕДУПРЕЖДЕНИЕ
Пакеты из репозитория Chocolatey `12.0.2` (pocc 12.00.1) и `11.0.2` (pocc
11.00.3) работают с CMake, похоже, только под Windows 2022.

Команда `cc` имеет ограничения:
- Ошибки, в случае если `cc` вызывается по пути, который имеет пробелы;
- Версия `11.0.2`, несовместима с Windows 2022/2025;

Подробности смотрите [Test Pelles C](
https://github.com/Serge3leo/test-pellesc/blob/main/.github/workflows/test-pellesc.yml).

Если необходимо CMake автоопределение компилятора `cc`, для их обхода можно
использовать два варианта:
1. Установку Pelles C в каталог без пробелов в пути (параметр
   [location](#location)).  Используется по умолчанию;
2. Установку переменных окружения в форме SFN (Short File Names, параметр
   [env-workaround](#env-workaround).  Зависит от версии CMake.

# Использование
```
  - uses: Serge3leo/pellesc-setup@v0
```

или

```
  - uses: Serge3leo/pellesc-setup@v0
    with:
      version: 12.0.2
      verbose: true
```

Пример совместного использование в проекте CMake можно увидеть:
  - [Learn CMake on GitHub multiple platforms](
    https://github.com/Serge3leo/learn-cmake/blob/main/.github/workflows/learn_cmake.yml);
  - [cmake-multi-platform.yml](.github/workflows/cmake-multi-platform.yml);
  - [C23/C++14 platform independent implementation of C2y countof()](
    https://github.com/Serge3leo/countof_ns/blob/main/.github/workflows/cmake-multi-platform.yml).

# Параметры
## cache
  - Тип: `boolean`
  - Значение по умолчанию: `true`

Для ускорения повторного использования, кэшировать каталог установки Pelles C.

Возможно будет полезно использовать дополнительные рабочие процессы для
удаления тех кэшей, использование которых становится маловероятным (после
закрытия PR и т.п.).  Шаблоны таких процессов: [Clean Cache Action](
https://github.com/marketplace/actions/clean-cache) или
https://github.com/marketplace/actions/clean-cache-action .

## cmake
  - Тип: `string`
  - Допустимые значения: исполняемая команда (путь) `cmake`
  - Значение по умолчанию: `cmake`

Задаёт команду `cmake`, используемую при установке модулей поддержки (т.е.
после установки именно эта команда `cmake` будет поддерживать компилятор Pelles
C).

## cmake-module
  - Тип: `string`
  - Допустимые значения: `check | always | no`
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

## key-prefix
  - Тип: `string`

Добавляет префикс к ключу кэш (для обновления версии, идентификации и т.п.).

## location
  - Тип: string
  - Допустимые значения: имя каталога или пустая строка
  - Значение по умолчанию: `c:\pellesc`

Если явно задано пустым, то каталог установки задаётся программой установки
Pelles C, для существующих версий `C:\Program Files\PellesC`.

## verbose
  - Тип: `boolean`
  - Значение по умолчанию: `false`

Печатает пути и версии основных компонент: `pocc`, `make`, `cmake`, ...

## version
  - Тип: `string`
  - Значение по умолчанию: `14.10-git-lfs`

Если не задан, устанавливается версия `14.10-git-lfs` из этого репозитория
(14.10, 24 Апр 2026, [https://www.pellesc.se](https://www.pellesc.se)), которой
нет у Chocolatey Community.  Иначе будет установлена указанная версия.  При
явном задании пустого значения, будет установлена последняя версия от Chocolatey
Community.  Список доступных версии приведён:
[https://community.chocolatey.org/packages/pelles-c](https://community.chocolatey.org/packages/pelles-c).

# Результаты

Если параметр `cmake-module` не был равен `no`:

- CMAKE_ROOT - Полный путь к каталогу установки модулей PellesC;
- CMAKE_COMMAND - Полный путь команды `cmake`.

# Участие
Замечания (issues), добавления или исправления (pr) - принимаются и
приветствуются.

# Лицензия
[BSD-2-Clause © 2026 Сергей Леонтьев (leo@sai.msu.ru).](LICENSE)
