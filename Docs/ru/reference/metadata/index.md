---
layout: default
title: Сгенерированный API и метаданные
locale: ru
document_id: generated-api-metadata
permalink: /Docs/ru/reference/metadata/
---
<!-- docs-translation: {"document_id":"generated-api-metadata","locale":"ru","source_path":"Docs/en/reference/metadata/index.md","source_sha256":"52aa761d8f259d45706e4d9a0f9b4cf947ee336010bc0c9dd077faedd4d32186"} -->

# Сгенерированный API и метаданные

Это руководство владеет переиспользуемым потоком аннотаций исходников, генерации кода и runtime-метаданных. Подключающий проект передаёт свою конфигурацию, дополнительные native-метаданные, скрипты и контент. Сгенерированные справочники описывают этих владельцев, а не являются независимыми источниками поведения.

Порядок зависимостей задаёт [работа со сгенерированным содержимым](../../how-to/build/generated-content.md), правила авторства, генерации и доказательств — [сопровождение документации](../../contributing/documentation/). Собственные native, managed, Python и structural unit suites форка удалены. Архивированные workflows не являются активным CI. Используйте существующие проверки генераторов, configure/compile/bake затронутых ролей и прямые пути приложения; новые автоматизированные тесты и их инфраструктура требуют явного запроса.

## Модель владения

Engine владеет переиспользуемым механизмом metadata/codegen. Подключающий проект передаёт project configuration, extra metadata sources, common headers и script/content inputs через CMake options и project files. Generated files являются build artifacts: сопровождайте source annotations, templates, generator inputs и validation flow, не generated C++ вручную.

## Проверенные исходные пути

- `BuildTools/cmake/stages/Codegen.cmake`, `EngineSources.cmake` и `BuildTools/cmake/helpers/Build.cmake`
- `BuildTools/codegen.py`, `BuildTools/docs_api.py`, `BuildTools/docs_reference.py`
- `Source/Common/MetadataRegistration.h`, `.cpp` и `.template.cpp`
- `Source/Common/GenericCode.template.cpp`, `Properties.h` и `Properties.cpp`
- `Source/Tools/MetadataBaker.cpp`, `Source/Tools/ManagedScriptBaker.cpp`
- `Source/Scripting/Managed/ManagedInteropAbi.h` и `.cpp`
- `Docs/documentation-manifest.json`, `Docs/description-translations.ru.json`
- пары моделей и генераторов ниже

## Стадия codegen в CMake

`BuildTools/cmake/stages/Codegen.cmake` строит команду генератора и список результатов. Важные аргументы: `-maincfg`, `-buildhash`, `-genoutput`, `-devname`, `-nicename`, `-embedded`, повторяемые `-meta` и `-commonheader`, а также повторяемые literal-записи `-enginedefine NAME=VALUE`.

`-enginedefine` переносит configuration/shape macros в `EngineConfig.gen.h`; feature/backend toggles и зависящий от конфигурации `FO_DEBUG` остаются на стороне компилятора. Стадия создаёт обычные/принудительные codegen targets и добавляет `CodeGeneration` в generated dependencies. `InternalConfig.gen.inc` резервирует фиксированную принадлежащую Engine область patch пакета в 20000 байт; проект не может изменить её размер.

## Генерируемые результаты

В `GeneratedSource/` бинарного каталога CMake codegen объявляет `CodeGenTouch`, `EngineConfig.gen.h`, `EmbeddedResources.gen.inc`, `InternalConfig.gen.inc`, ролевые `MetadataRegistration-*.gen.cpp`, включая stubs, и `GenericCode-Common.gen.cpp`.

`EngineConfig.gen.h` содержит Engine/project build identities и configuration macros; см. [версии Engine](../../how-to/release/versioning.md). Изменяйте шаблоны, аннотации и входы, а не generated C++ вручную. Выходы baker, например `ModelAnimationInfo.foinfo`, принадлежат отдельной стадии ресурсов; их смысл определяет [анимация моделей](../../how-to/content/model-animation.md).

## Каноническая модель API документации

[api.json](../../../generated/api.json) — каноническая машинная модель native-codegen поверхности Engine. `docs_api.py` открывает read-only metadata session в `codegen.py`, а не поддерживает другой C++ parser. Модель охватывает enums/values, value layouts, ref types/members, сущности, свойства, методы, события, настройки, migration rules и API contracts.

Записи имеют стабильный `family_id`, уникальный `id`, kind, стороны, receiver, нормализованную сигнатуру, flags, description, source provenance, stability/lifecycle data и explicit/default contract provenance. Аргументы сохраняют defaults, nullability и передачу по ссылке. IDs перегрузок используют детерминированные хеши сигнатур; изменение сигнатуры поэтому может выглядеть как удаление/добавление.

Числа, покрытие описаниями/исходниками и итоги классификации принадлежат generated `summary`, а не скопированному тексту. Неклассифицированная запись по умолчанию `internal`. Фактическую классификацию текущей области задаёт inventory-pinned `ApiContract` в `Source/Common/Common.h` с точными overrides; нельзя описывать все символы как default-internal или копировать старое число символов. Доступность не обещает стабильности.

Настройки одного блока `ExportSettings` сейчас разделяют строку его аннотации. `command_line_redacted_by_default` описывает только стандартную политику маскирования токенов командной строки, а не классификацию credentials или гарантию секретности.

### Описания символов в исходниках

Описание располагается у декларации: adjacent/inline export comments, trailing enum-entry comments и ref-type member comments. Поля value layout используют `// fieldName: description` непосредственно перед `ExportValueType`; неизвестные, повторные или пустые field descriptions останавливают генерацию. Generated property-enum entries наследуют текст и location свойства. Описания не входят в runtime compatibility hash; стабильностью владеют отдельные `ApiContract`.

### Аннотации API contract

`///@ ApiContract <selector> <stability> ...` выбирает точный ID, overload family либо `scope:native-codegen`. Область требует актуальных положительного `SymbolCount` и lowercase 64-hex `InventorySha256` от отсортированных стабильных IDs, разделённых переводами строк. Берите оба из реально проверенного inventory, а не константы урока. Устаревшие pins, неизвестные selectors, пересечения exact/family declarations и неполные lifecycle fields отклоняются; exact declaration может переопределить единственную scope declaration.

У `internal` нет lifecycle fields; `stable` и `experimental` требуют `Since`. Схема метаданных умеет представлять исторические `deprecated` records с `DeprecatedSince`, существующей `Replacement` и `Removal`, но это не разрешает сохранять obsolete API aliases: заменами управляют [ADR-0002](../../contributing/decisions/0002-public-api-stability-contract.md) и [политика текущего API](../../how-to/release/versioning.md#актуальный-api-и-миграции-бд). Повторяемые `Example` должны указывать существующие локальные пути или URLs. Contract notes не заменяют symbol descriptions. Documentation-only contracts не должны менять runtime compatibility hashes.

Сначала регенерируйте API model, затем human projection:

```bash
python BuildTools/docs_api.py --write
python BuildTools/docs_api.py --check
python BuildTools/docs_reference.py --write
python BuildTools/docs_reference.py --check
```

## Сгенерированный Markdown-справочник

[Справочник native script API](../script-api/index.md) проецирует canonical JSON в методы, свойства, события, типы, настройки и миграции. `Docs/generated/api/*.md` — долговечные legacy routes. Renderer не выводит отсутствующие descriptions и не создаёт другой inventory. Сначала исправляйте source/parser/model owner; нельзя вручную чинить неверную generated table. Русский текст моделей поступает через проверенный `Docs/description-translations.ru.json`, не через English fallback или обновление одного хеша. См. [процесс перевода](../../contributing/documentation/translation.md).

## Домены сгенерированных контрактов

Текущим перечнем доменов и stability labels владеет [индекс публичных контрактов](../public-contract/index.md). Числа и точные records берите из его generated models. Маршруты ниже указывают production owners, не удалённые test prerequisites.

| Домен | Авторский владелец / фактический источник | Генератор | Справочник |
| --- | --- | --- | --- |
| CMake | `BuildTools/cmake/ProjectInterface.json`; `Init.cmake`, stages/helpers | `docs_cmake.py` | [CMake](../cmake/index.md) |
| Main CLI | `buildtools.py::create_parser()` | `docs_cli.py` | [BuildTools](../buildtools/index.md) |
| Helper CLI | `HelperCliInterface.json`; executable parser factories | `docs_helper_cli.py` | [Helpers](../helper-cli/index.md) |
| Native extensions | `NativeExtensionInterface.json`; CMake/codegen/hooks | `docs_native_extension.py` | [Native extensions](../native-extension/index.md) |
| Prototypes | `PrototypeFormatInterface.json`; prototype bakers/properties | `docs_prototype_format.py` | [Прототипы](../prototype-format/index.md) |
| Maps | `MapFormatInterface.json`; loader/baker/Mapper/runtime | `docs_map_format.py` | [Карты](../map-format/index.md) |
| Models | `ModelFormatInterface.json`; model parser/baker/runtime | `docs_model_format.py` | [Модели](../model-format/index.md) |
| Text | `TextFormatInterface.json`; text bakers/packs/runtime | `docs_text_format.py` | [Текст](../text-format/index.md) |
| Effects | `EffectFormatInterface.json`; effect baker/renderers | `docs_effect_format.py` | [Эффекты](../effect-format/index.md) |
| Images | `ImageFormatInterface.json`; image baker/sprite factories | `docs_image_format.py` | [Изображения](../image-format/index.md) |
| Particles | `ParticleFormatInterface.json`; backend registries/bakers/runtime | `docs_particle_format.py` | [Частицы](../particle-format/index.md) |
| Fonts | `FontFormatInterface.json`; font loader/layout/rendering | `docs_font_format.py` | [Шрифты](../font-format/index.md) |
| Audio | `AudioInterface.json`; audio baker/resource/audio managers | `docs_audio.py` | [Аудио](../audio/index.md) |
| Video | `VideoInterface.json`; raw copy/video playback | `docs_video.py` | [Видео](../video/index.md) |
| Packages | `PackageInterface.json`; `DefinePackage` и `package.py` | `docs_package.py` | [Пакеты](../packages/index.md) |
| AiControl | `AiControlProtocol.json`; reference client/sample | `docs_ai_control_protocol.py` | [AiControl](../ai-control-protocol/index.md) |

Пути owner/generator без другого корня находятся в `BuildTools/`. `--write` каждого генератора обновляет объявленные model/reference outputs; `--check` сравнивает текущие результаты. Перед вызовом прочтите актуальный parser/source. Паритет подтверждает только свойства этого генератора, не runtime support всех backend/platform.

### Сгенерированный интерфейс CMake проекта

JSON описывает реализованные CMake declarations, а не объявляет executable options. Поддерживаются только source roles, потребляемые реальными targets. Произвольная регистрация метаданных через `AddEngineSources` не доказывает компиляцию роли.

### Сгенерированный справочник BuildTools CLI

Help, choices, cardinality и defaults берутся из executable parser. Project build commands используют свой документированный cwd; запуск из корня Engine не универсален.

### Сгенерированный справочник helper CLI

Inventory helpers явный и сопоставляется через AST с parser factories. Он отделён от main CLI/package models и не подразумевает поддержку удалённых test/coverage helpers.

### Сгенерированный интерфейс native extensions

Roles, hook signatures/fallbacks и binding rules — revision-pinned source contracts, не cross-revision binary ABI. См. [Native Extensions](../../how-to/native-extensions.md).

### Сгенерированный справочник prototype format

Grammar model выводит built-in properties из текущей native API model; каталоги проекта и семантические сочетания принадлежат проекту.

### Сгенерированный справочник map format

Модель разделяет authoring, ролевое baking и runtime ownership. Quantity/stacking не являются встроенным контрактом `Item.Count`.

### Сгенерированный справочник model format

Модель проецирует accepted parser tokens, composition и metadata bounds/animation. Порядок и видимая приёмка описаны в соответствующем руководстве.

### Сгенерированный справочник text format

Модель охватывает raw syntax, language normalization и lookup; успешный bake не устанавливает наличие авторского base language каждого pack или паритет ключей проекта.

### Сгенерированный справочник effect format

Модель охватывает pass state, resources и backend artifacts; промежуточная компиляция HLSL не означает сохранённый HLSL payload.

### Сгенерированный справочник image format

Модель разделяет source formats, private baked bytes, runtime factories и failure/sprite caches.

### Сгенерированный справочник particle format

Модель описывает backend capabilities, cooked bounds и renderer restrictions. Backend-neutral facade не делает все возможности backend взаимозаменяемыми.

### Сгенерированный справочник font format

Descriptor parsing, font slots, metrics и draw semantics принадлежат Engine; проектные glyph/localization и видимая приёмка проверяются отдельно.

### Сгенерированный справочник audio

Decoding, exact-path delivery и mixing primitives не владеют каталогом звуков игры, spatialization или audible qualification.

### Сгенерированный справочник video

Примитив Ogg/Theora не является полной системой cinematics, subtitles, container audio или streaming.

### Сгенерированный интерфейс packages

`CONFIG`, повторяемый `BINARY`, per-entry `POSTFIX` и `INCLUDE` должны совпадать с реальным declaration parser. Проверки упаковки не доказывают поведение installer, signing, deployment или установленного runtime.

### Сгенерированный справочник протокола AiControl

Исполняемый `Examples/AiControlSample/run_protocol_smoke.py` проверяет project-neutral protocol sample, а не native game client или игровой процесс.

## Сгенерированный реестр публичных example repositories

`Examples/PublicRepositories.json` и `Examples/PublicRepositoryTemplate/` служат входами `docs_examples.py` и [реестра публичных примеров](../public-examples/index.md). Pinned validation кандидата требует совпадения declared pin, committed Engine gitlink и checked-out revision. Current-compatibility mode сообщает временно проверенную ревизию, не заменяя release pin. Governance, provenance и publication authority остаются явными; будущая политика внешнего CI не доказывает наличие CI или опубликованных репозиториев этого форка.

## Inventory примеров документации

`SnippetPolicy.json` и `docs_snippets.py` инвентаризируют canonical fenced blocks в generated snippets report. Parser coverage не является семантической компиляцией или выполнением. `--external` дополнительно требует установленных Bash/PowerShell parsers и не исполняет команды. После изменения fences регенерируйте до localization/site/AI delivery; см. [проверку примеров](../../contributing/documentation/snippets.md).

## Артефакты доказательств и media

`ExternalProjectEvidence.json`, `DocumentationDiagrams.json` и `DocumentationScreenshots.json` владеют соответственно external revision provenance, deterministic diagram sources и screenshot capture inputs. Их генераторы проверяют/обновляют отчёты. Внешние проекты не переопределяют исходники Engine. Диаграммы регенерируются через владельца, скриншоты переснимаются при срабатывании triggers; нельзя объявить необъяснённое изображение актуальным новым хешем. Исторические отчёты остаются историческими доказательствами.

## Сгенерированный статус поддержки и локализации

`SupportMatrix.json`/`docs_support_matrix.py` разделяют source capability, build и runtime evidence. `docs_localization.py` проверяет identity пары, нормализованный EN source hash, порядок и паритет fences и locale-preserving links, затем владеет `docs-manifest.json#/translation_status`. Текущее complete enforcement требует всех обязательных зеркал. Свежий хеш не является семантическим рецензированием перевода.

## Доставка документации для ИИ

`docs_ai_delivery.py` проецирует авторский manifest в логические публичные маршруты `llms.txt`, `llms-full.txt` и `docs-manifest.json`. Локальные outputs находятся в ignored `Workspace/Documentation/` по mapping `documentation_metadata.py`, а не в авторских файлах корня репозитория. `docs_prepare.py` готовит там и site inputs. `docs_site_build.py` собирает `Workspace/DocumentationSite/`. Публичные upstream URLs не доказывают deployment форка.

`Docs/ai-evaluation.json` и `docs_ai_eval.py` владеют deterministic retrieval checks, не приёмкой ответов модели или runtime. Полные bundles исключают generated detail pages в пользу canonical models. См. [ADR-0003](../../contributing/decisions/0003-manifest-backed-ai-documentation-delivery.md).

## Данные сайта документации

`docs_site.py` владеет navigation/search и `docs-manifest.json#/routing`, сохраняя localization data; AI delivery сохраняет оба раздела и обновляет хеши. Порядок: snippets, localization, site/search/routes, затронутая AI evaluation, затем AI delivery последним. Rendered-artifact и browser checks — отдельная приёмка с зависимостями по [публикации сайта](../../contributing/documentation/site-publication.md), а не автоматическое следствие source validation. Установка и публикация не подразумеваются.

## Multi-domain diff и решения по изменениям

`docs_contract_diff.py` сравнивает все текущие canonical generated models с теми же путями точной baseline revision. Native entries передаются `docs_api_diff.py`. Breaking classification использует baseline stability; обязательное disposition — точная domain-bound entry, и смена текущей метки на `internal` не обходит gate. Model-source/scope/contract changes тоже требуют disposition. Точные domain/base/current digests сохраняются в `Docs/contract-change-dispositions.json`, revision-pair reports — в ignored workspace outputs. См. [управление изменениями контрактов](../../contributing/contract-change-management.md). Локальные range checks обязательны и при архивированных workflows.

## Дополнение project remote calls

Project `.fos`/`.cs` remote calls запекаются `MetadataBaker`, а не добавляются в `api.json` другим parser. `docs_metadata.py` декодирует paired authoritative metadata, требует совпадения signatures/limits и создаёт каталог проекта. Из корня подключающего проекта:

```bash
python Engine/BuildTools/docs_metadata.py \
  --root . \
  --metadata Baking/Metadata/Metadata.fometa-server \
  --metadata Baking/Metadata/Metadata.fometa-client \
  --write
```

После baking используйте те же inputs с `--check`. Каталог содержит input hashes, backend-correct handler syntax и `MaxBytes`/`MaxCollectionSize`, включая явные нулевые limits. Source hints не сохраняют полные repository paths/lines или declaring type/actual task return Managed. Managed RPC поддерживает допустимые scalars/arrays, а не dictionaries только потому, что их умеет callback marshalling. Полный authority/serialization contract принадлежит [Remote Calls](../scripting/remote-calls.md).

## Точки входа регистрации метаданных

`MetadataRegistration.h` объявляет side/stub `Register*Metadata`, `RegisterDynamicMetadata`, `ReadMetadataBin` и `ReadMetadataVersion`. Templates задают generated registration/common code. Runtime dynamic metadata включает enums, entities/holders, value/ref/fixed types, properties, events, remote calls, settings и migrations.

## Теги engine hooks

Имена/сигнатуры `EngineHook` закрыты codegen и [справочником hooks](../native-extension/hooks.md). Отсутствующие optional hooks получают generated fallbacks; проектные declarations подавляют их. Configuration hooks возвращают `void` и меняют переданный `GlobalSettings&` при startup construction, а не возвращают boolean change signal и не меняют live gameplay settings. Присутствие `ApplicationShutdownHook` намеренно не входит в compatibility hash; поведение остальных hooks следует их lifecycle contract.

## Promotion script `Entity`

Script `Entity` преобразуется в target-specific native entity classes. Proto/abstract casts не обходят target ownership: native marshalling читает base handles и checked-narrows к target, выбрасывая исключение при sibling-type mismatch. Null/destroyed-element policy массивов определяется конкретным API. Для entity dictionary keys и dictionary-nested entity arrays нет поддерживаемого conversion contract; они отклоняются.

## Динамические метаданные

Native declaration parser принимает migration kinds `Version`, `Property`, `Proto`, `Component`, `Remove` и `Enum`, но не `Entity`/`EntityHolder`. Действия Property/Proto `Rename`/`Transform` имеют пять tokens; `Remove` — четыре без replacement. Property destinations должны существовать; transform требует Persistent property и synchronous attributed callback. Все callbacks читают исходный неизменённый document; результаты подготавливаются до enqueue, исключение оставляет document/update queue нетронутыми. Это не database-wide transaction. Removed-name rules являются постоянными tombstones; старые top-level database keys могут остаться. См. [Managed migrations](../../how-to/scripting/managed-csharp.md#миграции-значений-свойств-документа) и [AngelScript migrations](../../how-to/scripting/style-and-refactoring.md#миграции-документов).

Holder side filtering предшествует type lookup; shared off-target holders сохраняют Stub properties, неизвестные active-side types останавливают baking. Enum name remaps применяются при persisted-value resolution, включая scalar values и dictionary keys, а не как старый callable API.

### Версия метаданных

**Сервер и его клиенты должны работать на метаданных одной bake.** Property indices зависят от registration order. Одной native compatibility недостаточно: project metadata регистрируется из baked resources. `MetadataBaker` хеширует полный parsed tag stream до side filtering, поэтому одна bake разделяет metadata version между ролями.

Каждый файл начинается magic, `uint16` file-layout version и length-prefixed metadata version. Изменение reader/writer tokens требует file-version bump даже без изменения tag hashes. Header helpers отклоняют foreign/truncated/old-layout input до section decoding. Не копируйте file-version constant в ручной текст как владельца inventory.

Инвариант обеспечивают совместное server/client deployment, startup comparison updater на сервере, post-sync reread updater до `ClientEngine` и финальная race check gameplay handshake. `Properties::VerifyRestoredPropertyData` отдельно проверяет target enablement, virtual flags и plain-data size. `Network.ForceMetadataVersion` — только diagnostic override, не production compatibility mode. Ищите неверные каталоги и reported versions; не подавляйте mismatch guard.

## Свойства и generated contracts

`Properties.*` владеет raw data, registrars, typed storage, callbacks и serialization. `hstring` имеет общую восьмибайтовую native/value ABI width, но persistence/wire serialization использует resolved hash, а не pointer padding. Registered fixed value layouts — packed trivially-copyable native data с выровненными offsets и без tail padding; identity-bearing, string/collection и unsupported nested data относятся к ref types.

Managed baking выводит indexed `ManagedInteropAbi` slots/nullability/factories/adapters из тех же metadata. Early binding отклоняет count/hash mismatch; generated API/ABI files участвуют в incremental stamps. Wrappers принадлежат backend load context, явно связывают Engine ownership и отклоняют access после unbind; поздний finalizer не вызывает освобождённое native state. См. [Managed C#](../../how-to/scripting/managed-csharp.md).

## Связь с публичным API

Перечень доменов берите из generated [индекса публичных контрактов](../public-contract/index.md), точные native records — из [native API model](../../../generated/api.json). Классификация следует source-owned scope/exact contracts, не скопированным числам или предположениям о defaults. Полный inventory не обещает общей стабильности или binary compatibility.

## Связь metadata и baker

Codegen создаёт compiled C++/include inputs; `MetadataBaker` создаёт side-specific resource metadata; runtime registration потребляет второе. Корректная source model не доказывает, что compile, bake или deployment выбранного проекта использовали её.

## Проверка и маршрутизация изменений

При изменении annotations/signatures регенерируйте native model/reference и проверьте diff; configure/compile затронутых native roles и каждого выбранного script backend, bake обеих сторон ресурсов, paired project metadata check, затем затронутый application path. Для serialization квалифицируйте isolated save/reload/restart и обновляйте source-owned migration/compatibility metadata. Для model prose исправляйте owner и reviewed RU overlay до regeneration. Для documentation-only изменений после свежих prerequisites запускайте relevant existing generator checks и standalone snippet/localization/corpus checks. Указывайте точный target, команды, outcomes и gaps; удалённая suite, архивный workflow или успешный generator сами по себе не доказывают runtime correctness.
