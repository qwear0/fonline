---
layout: default
title: "ADR-0005: владение публичными репозиториями примеров"
locale: ru
document_id: adr-public-example-repository-ownership
permalink: /Docs/ru/contributing/decisions/0005-public-example-repository-ownership.html
---
<!-- docs-translation: {"document_id":"adr-public-example-repository-ownership","locale":"ru","source_path":"Docs/en/contributing/decisions/0005-public-example-repository-ownership.md","source_sha256":"59a74e37c75613575602cb821c00502b6d90505e1f91d4e984e7b5f3a5a968c8"} -->
# ADR-0005: владение публичными репозиториями примеров

- Статус: принято
- Дата: 2026-07-15
- Владельцы: документация, сборка и выпуск, runtime, content, администраторы репозиториев

## Применимость к форку

Портфель внешних repositories и protected/scheduled CI lanes ниже — будущая governance отдельно разрешённых опубликованных примеров, не доказательство, что форк создал их или включил CI. Собственные workflows архивированы, unit suites удалены. Проверяйте текущие локальные registry/scaffolds существующими checks и application routes; не создавайте неявно tests, repositories, remote settings или releases.

## Контекст

FOnline нужны исполняемые публичные примеры, которые меньше и понятнее производственных игр. Один крупный пример смешал бы bootstrap, gameplay, assets, нативную интеграцию, выпуски и проектную политику. Незакреплённые примеры расходились бы с Engine `master`; копирование материалов Last Frontier или TLA поставило бы повторно используемую документацию в зависимость от кода и лицензий другого проекта.

Движок уже владеет исполняемым headless scaffold в `Examples/MinimalProject`, сгенерированными справочниками контрактов, самостоятельным сайтом документации и историческими upstream CI smoke routes. При принятии этого решения у него не было машиночитаемого портфеля внешних репозиториев, общих governance files, проверки точных pins, политики scheduled compatibility, контракта provenance ресурсов или границы полномочий публикации.

## Решение

1. Поддерживать четыре репозитория с отдельными областями ответственности: `fonline-project-template`, `fonline-minimal-multiplayer`, `fonline-content-showcase` и `fonline-native-extension-sample`.
2. Хранить авторитетный портфель в `Examples/PublicRepositories.json`; генерировать публичную проекцию JSON/Markdown при помощи `BuildTools/docs_examples.py`.
3. Хранить общие governance и workflow templates в `Examples/PublicRepositoryTemplate`. Перед публикацией любого репозитория применять и полностью материализовывать этот overlay.
4. Репозиторий движка владеет повторно используемой политикой, проверкой и каноническими source scaffolds. Каждый внешний репозиторий владеет своим example code, assets, issues, tags и artifacts. Исходный код, тесты и документация движка остаются нормативными при расхождении с примером.
5. Release и tutorial builds закрепляют `Engine/` на точном commit одновременно в gitlink и `example-repository.json`. Плавающие ссылки на Engine запрещены для release artifacts.
6. Каждый репозиторий выполняет защищённый pinned-Engine lane и еженедельный current-Engine compatibility lane. Результаты current-Engine приводят к проверенным pull request обновления и никогда не меняют release pins автоматически.
7. Каждый распространяемый ресурс имеет машиночитаемые source, license, path и SHA-256 provenance. Даже пример без ресурсов содержит пустой корректный provenance file.
8. Создание репозитория, доступ, security settings, visibility, Pages и публикация релиза являются административными действиями, требующими разрешения владельца. Подготовка локальных исходников не разрешает push или публикацию.
9. Публичная документация ссылается только на репозитории и tags, статус которых в registry равен `published` и exit gate которых проверен.
10. Нативные клиентские примеры считают генерацию updater protocol и ABI client host/runtime явными границами выпуска. Несовместимый замороженный host требует полного клиентского пакета, а не обходного in-process reload.

## Последствия

- Разработчики и ИИ-агенты могут отличать нормативные контракты движка от иллюстративной композиции проекта.
- Tags, artifacts, logs, screenshots и tutorials воспроизводимы из точного commit движка.
- Scheduled compatibility failures становятся видны до перемещения pin документации или выпуска.
- Общие файлы безопасности, участия, поддержки, CI и provenance остаются согласованными без импорта workflow производственной игры.
- Публикация первого внешнего репозитория требует административного действия и успешного CI; этот ADR намеренно не создаёт и не отправляет репозиторий.
- Четыре репозитория добавляют работу по сопровождению, но каждый остаётся достаточно малым, чтобы иметь одну ответственность и явный exit gate.

## Отклонённые варианты

### Один всеобъемлющий пример игры

Отклонён, поскольку накапливал бы несвязанные системы, скрывал первые шаги и стал бы ещё одним производственным проектом.

### Сборка выпусков из Engine `master`

Отклонена, поскольку сгенерированные контракты, нативная совместимость, artifacts и tutorials не были бы воспроизводимыми.

### Использование Last Frontier или TLA как канонического примера

Отклонено, поскольку оба проекта содержат проектную политику, assets, services и ограничения рефакторинга, которые не могут определять самостоятельный повторно используемый контракт движка.

### Независимое копирование workflow и policy files в каждый репозиторий

Отклонено, поскольку незаметный drift сделал бы утверждения о безопасности, совместимости и поддержке несогласованными. Общим источником служат принадлежащие движку overlay и validator.

## Проверка

- `python BuildTools/docs_examples.py --check`
- `python BuildTools/docs_validate.py`
- отдельно проверяйте оба обязательных compatibility lanes каждого действительно опубликованного external repository; local registry entry или template не доказывают их выполнение

## Связанные документы

- [Публичные репозитории с примерами](../../how-to/build/public-example-repositories.md)
- [ProductionDocumentationPlan.md](https://github.com/cvet/fonline/blob/master/Docs/ProductionDocumentationPlan.md)
- [ADR-0006](0006-documentation-version-locale-routing.md)
