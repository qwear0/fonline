---
title: Роли нативных расширений
document_id: generated-native-extension-roles
locale: ru
generated: true
---

<!-- docs-translation: {"document_id":"generated-native-extension-roles","locale":"ru","source_path":"Docs/en/reference/native-extension/roles.md","source_sha256":"1736c8897d8ee8489f4b000ed59816ae9edbcda660d716811d85e7bc6071d2fd"} -->

# Роли нативных расширений

> Сгенерированный справочник. Не редактируйте его напрямую. Обновите `BuildTools/NativeExtensionInterface.json`, затем выполните `python BuildTools/docs_native_extension.py --write`.

[Обзор](index.md) | [Роли](roles.md) | [Хуки](hooks.md) | [Биндинги](bindings.md) | [Канонический JSON](../../../generated/native-extension.json) | [Руководство](../../how-to/native-extensions.md)

Это роли, которые используются текущими целями Engine. Каждый найденный исходник также добавляется в `FO_SOURCE_META_FILES` до кодогенерации.

| Стабильный ID | Роль | Список исходников | Библиотека | Основной заголовок | Потребители | Скриптовые цели | Назначение |
| --- | --- | --- | --- | --- | --- | --- | --- |
| <a id="entry-native-extension-role-common-7fefc75aab"></a><code>native-extension.role.common</code> | <code>COMMON</code> | <code>FO_COMMON_SOURCE</code> | <code>CommonLib</code> | <code>Common.h</code> | <code>client</code>, <code>server</code>, <code>mapper</code>, <code>baker</code>, <code>animation-viewer</code>, <code>particle-viewer</code>, <code>ascompiler</code> | <code>common</code> | Код, общий для каждой включённой роли движка; используйте только для действительно общих зависимостей и хуков. |
| <a id="entry-native-extension-role-server-a000ac35db"></a><code>native-extension.role.server</code> | <code>SERVER</code> | <code>FO_SERVER_SOURCE</code> | <code>ServerLib</code> | <code>Server.h</code> | <code>server</code> | <code>server</code> | Авторитетный серверный код и экспорты в серверные скрипты. |
| <a id="entry-native-extension-role-client-a9db128cb5"></a><code>native-extension.role.client</code> | <code>CLIENT</code> | <code>FO_CLIENT_SOURCE</code> | <code>ClientLib</code> | <code>Client.h</code> | <code>client</code>, <code>server</code>, <code>mapper</code>, <code>baker</code>, <code>animation-viewer</code>, <code>particle-viewer</code>, <code>ascompiler</code> | <code>client</code>, <code>mapper</code> | Код среды выполнения клиента; пути контроллера сервера, Mapper, оба специализированных просмотрщика, BakerLib и ASCompiler линкуются с ClientLib, но целями экспорта в скрипты являются только клиент и Mapper. |
| <a id="entry-native-extension-role-mapper-f90930cf33"></a><code>native-extension.role.mapper</code> | <code>MAPPER</code> | <code>FO_MAPPER_SOURCE</code> | <code>MapperLib</code> | <code>Mapper.h</code> | <code>mapper</code> | <code>mapper</code> | Нативные инструменты только для Mapper и экспорты в его скрипты. |
| <a id="entry-native-extension-role-baker-46164f8207"></a><code>native-extension.role.baker</code> | <code>BAKER</code> | <code>FO_BAKER_SOURCE</code> | <code>BakerLib</code> | <code>Baker.h</code> | <code>mapper</code>, <code>baker</code>, <code>animation-viewer</code>, <code>particle-viewer</code>, <code>ascompiler</code> | - | Расширения запекателя ресурсов, общие для Baker, Mapper, обоих специализированных просмотрщиков и ASCompiler; BAKER не является целью экспорта в скрипты. |

## Форма регистрации

```cmake
AddEngineSources(
    COMMON SourceExt/CommonExtension.cpp
    SERVER SourceExt/ServerExtension.cpp
    CLIENT SourceExt/ClientExtension.cpp)
RegisterEngineSources()
```

Пути и шаблоны разрешаются относительно корня вклада подключающего проекта. Текущий helper не отклоняет неизвестный token роли: он создаёт список FO_<ROLE>_SOURCE, но ни одна цель Engine не использует этот список, если роль не описана выше.
