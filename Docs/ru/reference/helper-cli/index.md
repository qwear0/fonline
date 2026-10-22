---
title: Сгенерированный справочник вспомогательных CLI
document_id: generated-helper-cli-index
locale: ru
generated: true
---

<!-- docs-translation: {"document_id":"generated-helper-cli-index","locale":"ru","source_path":"Docs/en/reference/helper-cli/index.md","source_sha256":"1699837cc75ba9a42917a0da7c5433d65d7c5571b6ad9fa0aedaeaea2409ad0c"} -->

# Сгенерированный справочник вспомогательных CLI

> Сгенерированный справочник. Не редактируйте эту страницу напрямую. Обновите `BuildTools/HelperCliInterface.json` или владеющий исполняемый парсер, затем выполните `python BuildTools/docs_helper_cli.py --write`.

[Индекс справочника](index.md) | [Команды](commands.md) | [Каноническая JSON-модель](../../../generated/helper-cli.json) | [Контракт генерации](../metadata/)

Этот справочник создаётся из объектов `argparse.ArgumentParser`, используемых исполняемыми вспомогательными скриптами движка. Манифест владеет назначением и аудиторией, а исходные парсеры владеют исполняемым синтаксисом.

## Статус контракта

| Поле | Значение |
| --- | --- |
| Стабильность | <code>internal</code> |
| Начиная с версии | Не объявлено |
| Политика поддержки | Командные строки helpers являются привязанными к ревизии интерфейсами реализации; автоматизация должна закреплять ревизию движка. |
| Исходный манифест | [BuildTools/HelperCliInterface.json](https://github.com/qwear0/fonline/blob/master/BuildTools/HelperCliInterface.json) |
| Digest контракта | <code>7b8389e6d0a022632dcfd7aba5afde42afac8e1d39c121c55cf3b089a9e6a102</code> |

## Инвентарь

| Стабильный ID | Helper | Владелец | Владелец вызова | Исходный парсер | Команды / глобальные аргументы |
| --- | --- | --- | --- | --- | --- |
| <a id="entry-helper-cli-codegen-60abdf415d"></a><code>helper-cli.codegen</code> | [Генерация кода](commands.md#entry-helper-cli-codegen-60abdf415d) | <code>build-release</code> | BuildTools/cmake/stages/Codegen.cmake | [BuildTools/codegen.py](https://github.com/qwear0/fonline/blob/master/BuildTools/codegen.py) | 0 / 10 |
| <a id="entry-helper-cli-gameplay-test-runner-b34ed8deb4"></a><code>helper-cli.gameplay-test-runner</code> | [Запуск игровых тестов](commands.md#entry-helper-cli-gameplay-test-runner-b34ed8deb4) | <code>quality</code> | CMake-цели подключающего проекта и CI smoke-задачи игровых тестов | [BuildTools/gameplay_test_runner.py](https://github.com/qwear0/fonline/blob/master/BuildTools/gameplay_test_runner.py) | 0 / 3 |
| <a id="entry-helper-cli-ai-control-client-35184e9731"></a><code>helper-cli.ai-control-client</code> | [Клиент протокола AiControl](commands.md#entry-helper-cli-ai-control-client-35184e9731) | <code>tooling</code> | ИИ-адаптеры проекта, smoke-тесты протокола и непосредственная диагностика разработчиком | [BuildTools/ai_control_client.py](https://github.com/qwear0/fonline/blob/master/BuildTools/ai_control_client.py) | 5 / 5 |
| <a id="entry-helper-cli-windows7-import-check-a0c7e4cb59"></a><code>helper-cli.windows7-import-check</code> | [Проверка импортов Windows 7](commands.md#entry-helper-cli-windows7-import-check-a0c7e4cb59) | <code>quality</code> | CI и релизная проверка Windows 7 подключающего проекта | [BuildTools/check_windows7_imports.py](https://github.com/qwear0/fonline/blob/master/BuildTools/check_windows7_imports.py) | 0 / 2 |
| <a id="entry-helper-cli-android-device-ab99179ae9"></a><code>helper-cli.android-device</code> | [Управление устройством Android](commands.md#entry-helper-cli-android-device-ab99179ae9) | <code>platform</code> | Android-задачи подключающего проекта и непосредственное использование разработчиком | [BuildTools/android_device.py](https://github.com/qwear0/fonline/blob/master/BuildTools/android_device.py) | 7 / 1 |
| <a id="entry-helper-cli-simple-web-server-58fbf70798"></a><code>helper-cli.simple-web-server</code> | [Локальный Web-сервер](commands.md#entry-helper-cli-simple-web-server-58fbf70798) | <code>platform</code> | payload WebServer в BuildTools/package.py | [BuildTools/web/simple-web-server.py](https://github.com/qwear0/fonline/blob/master/BuildTools/web/simple-web-server.py) | 0 / 2 |
| <a id="entry-helper-cli-createmsi-18899fd2a5"></a><code>helper-cli.createmsi</code> | [Создание MSI](commands.md#entry-helper-cli-createmsi-18899fd2a5) | <code>build-release</code> | пакет Wix в BuildTools/package.py | [BuildTools/msicreator/createmsi.py](https://github.com/qwear0/fonline/blob/master/BuildTools/msicreator/createmsi.py) | 0 / 2 |

## Покрытие

Модель содержит 7 helpers, 12 подкоманд, 25 глобальных аргументов и 24 аргументов подкоманд.

Включено:

- принадлежащие движку вспомогательные скрипты Python с фабрикой верхнего уровня create_parser();
- точные usage и вывод справки argparse, аргументы, подкоманды, владельцы, аудитории и контекст вызова.

Исключено:

- отдельно моделируемая командная строка BuildTools/buildtools.py;
- отдельно моделируемая командная строка BuildTools/package.py и контракт объявления пакетов;
- генераторы документации, тесты, библиотечные модули, shell-скрипты и инструменты подключающего проекта.
