---
title: Сгенерированная матрица поддержки
document_id: generated-support-matrix-index
locale: ru
generated: true
generated_by: BuildTools/docs_support_matrix.py
---

<!-- docs-translation: {"document_id":"generated-support-matrix-index","locale":"ru","source_path":"Docs/en/reference/platforms/generated-matrix.md","source_sha256":"cc99e86e84f282b5913f95fab7e451bb4e549478adfbbe82eaad4d50ed71b2a7"} -->

# Сгенерированная матрица поддержки

Страница проверяет актуальные цели BuildTools и отдельно сохраняет архивные определения workflow; в этом форке нет действующих CI-гейтов.
Архивные цели — историческая конфигурация, а не доказательство запуска сборки или процесса на текущей ревизии.

## Уровни подтверждения

| Уровень | Значение |
|---|---|
| `build_gated` | Зарезервировано для активного обязательного workflow, конфигурирующего и компилирующего профиль при каждом изменении; сейчас в этом форке нет профилей такого уровня. |
| `smoke_gated` | Зарезервировано для активного build gate и именованного автоматического process route; архивные workflow не являются свидетельством исполнения. |
| `source_capable` | Актуальный реестр BuildTools предоставляет цель. У форка нет активного обязательного CI gate; объявление цели не доказывает завершённую сборку или runtime-приёмку. |
| `not_in_public_matrix` | Для этой комбинации приложения и платформы не опубликована поддерживаемая цель проверки. |

## Профили платформ

| Хост / цель | Компилятор | Уровень | Приложения | Доступные локальные цели | Цели архивного workflow | Подтверждение runtime | Ограничения |
|---|---|---|---|---|---|---|---|
| Windows / Windows x64 | MSVC 19.44 или новее | `source_capable` | настольный и headless-клиент; сервер, headless-сервер и Windows Service; Mapper, AnimationViewer и ParticleViewer; компилятор AngelScript; Baker ресурсов | `win64-client`, `win64-server`, `win64-mapper`, `win64-ascompiler`, `win64-baker` | `win64-client`, `win64-server`, `win64-mapper`, `win64-ascompiler`, `win64-baker` | Проверяемый реестр валидации BuildTools не требует процессного smoke-маршрута. | Архивные определения линий — историческая конфигурация, не текущее build/runtime-свидетельство. Приёмка renderer, driver, database, packaging, deployment и lifecycle остаётся у проекта. |
| Windows / Windows x86 | MSVC 19.44 или новее | `source_capable` | настольный клиент | `win32-client` | `win32-client` | Процессный smoke-маршрут не требуется. | Серверные и инструментальные приложения не входят в опубликованную поверхность проверки x86. |
| Ubuntu 24.04 / Linux x64 | Clang 20 или новее | `source_capable` | настольный и headless-клиент; сервер, headless-сервер и daemon; Mapper, AnimationViewer и ParticleViewer; компилятор AngelScript; Baker ресурсов | `linux-client`, `linux-server`, `linux-mapper`, `linux-ascompiler`, `linux-baker` | `linux-client`, `linux-server`, `linux-mapper`, `linux-ascompiler`, `linux-baker` | Проверяемый реестр валидации BuildTools не требует процессного smoke-маршрута. | Ubuntu 24.04 — хост архивной линии, не свежая квалификация. Другие дистрибутивы, runtime, установщики, подпись, развёртывание и откат требуют приёмки проекта. |
| Ubuntu 24.04 / Linux x64 | GCC 13 или новее | `source_capable` | настольный и headless-клиент; сервер, headless-сервер и daemon; Mapper, AnimationViewer и ParticleViewer; компилятор AngelScript; Baker ресурсов | `linux-gcc-client`, `linux-gcc-server`, `linux-gcc-mapper`, `linux-gcc-ascompiler`, `linux-gcc-baker` | `linux-gcc-client`, `linux-gcc-server`, `linux-gcc-mapper`, `linux-gcc-ascompiler`, `linux-gcc-baker` | Отдельный процессный smoke-маршрут для GCC не требуется. | В этом форке ни GCC, ни Clang не имеют текущей обязательной runtime-линии. Квалифицируйте фактически поставляемые компилятор и артефакт. |
| runner-ы macOS 26 для Intel и Apple Silicon / macOS x64 и arm64 | AppleClang | `source_capable` | настольный клиент | `mac-client` | `mac-client` | Процессный smoke-маршрут клиента не требуется. | Публичная матрица не квалифицирует сервер, Mapper, инструменты, упаковку, подписание или notarization для macOS. |
| runner-ы macOS 26 для Intel и Apple Silicon / клиент iOS | AppleClang | `source_capable` | входные данные библиотеки клиента или пакета приложения | `ios-client` | `ios-client` | Smoke-маршрут на симуляторе или устройстве не требуется. | За provisioning, подписание, доставку через App Store, ввод и звук на устройстве, сеть и приёмку lifecycle отвечает проект. |
| хост кросс-сборки Ubuntu 24.04 / Android armeabi-v7a и arm64-v8a | Android NDK Clang | `source_capable` | входные данные динамической библиотеки или пакета клиента | `android-arm32-client`, `android-arm64-client` | `android-arm32-client`, `android-arm64-client` | Smoke-маршрут на эмуляторе или физическом устройстве не требуется. | За сборку APK, подписание, доставку через магазины, GPU, ввод и звук на устройстве, приостановку и возобновление, а также приёмку сети отвечает проект. |
| хост кросс-сборки / Android x86 | Android NDK Clang | `source_capable` | входные данные динамической библиотеки или пакета клиента | `android-x86-client` | - | Обязательная линия CI или runtime отсутствует. | Не объявляйте Android x86 поддерживаемой релизной целью без проектной проверки сборки и устройства или эмулятора. |
| хост кросс-сборки Ubuntu 24.04 / WebAssembly | Emscripten Clang | `source_capable` | браузерный клиент | `web-client` | `web-client` | Проверяемый реестр валидации BuildTools не требует браузерного процессного smoke-маршрута. | Штатная Web-цель — только клиент WebGL 2. Архивное определение cross-build не квалифицирует browser/GPU, hosting, headers, persistence, активацию аудио, packaging, развёртывание или откат. |
| Windows / Windows x64 | ClangCL 20 или новее | `source_capable` | настольный клиент; сервер; компилятор AngelScript; Baker ресурсов | `win64-clang-client`, `win64-clang-server`, `win64-clang-ascompiler`, `win64-clang-baker` | - | Обязательная линия CI или runtime отсутствует. | MSVC и ClangCL требуют проектных configure/build и runtime-свидетельств; активный CI этого форка сейчас не квалифицирует ни один из них. |

## Квалификация рендеринга

| Платформы | Скомпилированные backend | Граница квалификации |
|---|---|---|
| Windows, Linux, macOS | платформенный OpenGL, а также отключаемые Vulkan и SDL_GPU, если исходный backend может инициализироваться | Покрытие сборки не означает покрытие рендерера, runtime или драйвера; каждому поставляемому backend нужна видимая проектная сцена. |
| Android и iOS | OpenGL ES и возможности платформы; Vulkan и SDL_GPU вне Web остаются опциональными на этапе компиляции | Требуется приёмка на устройстве. |
| Web | WebGL 2 | Vulkan и SDL_GPU исключены этапом платформы; требуется приёмка в браузере. |
| headless-приложения | frontend null/headless | Не делайте вывод о поддержке видимого рендеринга или звука по headless smoke-тесту. |

## Сводка

- Профили платформ: **10**
- Профили с проверкой сборки: **0**
- Профили со smoke-проверкой: **0**
- Уникальные обязательные цели проверки CI: **0**

Правила интерпретации релизов и требования приёмки проекта приведены в [матрице поддержки](support-matrix.md).
