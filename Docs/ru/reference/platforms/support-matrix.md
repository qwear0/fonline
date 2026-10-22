---
layout: default
title: Матрица поддержки
locale: ru
document_id: support-matrix
permalink: /Docs/ru/reference/platforms/support-matrix.html
---

# Матрица поддержки
<!-- docs-translation: {"document_id":"support-matrix","locale":"ru","source_path":"Docs/en/reference/platforms/support-matrix.md","source_sha256":"c8be38440d999ef141698bf9b590cb1dd2baf88dcdb77dbfb644a484dbd5436c"} -->
Эта страница определяет, что документация текущего канала (`current`) FOnline
может называть поддерживаемым. Она разделяет наличие возможности в исходниках,
обязательную компиляцию в CI, автоматические процессные smoke-тесты и приёмку
релиза игрового проекта.

Текущие профили платформ и имена validation targets приведены в
[точной сгенерированной матрице](generated-matrix.md).
Машиночитаемая модель находится в
[support-matrix.json](../../../generated/support-matrix.json).

## Решение о поддержке

Используйте только эти уровни свидетельств: **Build-gated** означает, что
обязательный CI конфигурирует и компилирует профиль; **Smoke-gated** добавляет
автоматизированный process route; **Source-capable** означает наличие
возможности в исходниках без обязательного подтверждения CI; **Project-qualified**
означает повторяемую приёмку реального artifact встраивающей игрой. В матрице
релиза проекта должны быть явно указаны свидетельства Renderer, Networking,
Packaging и Updater. Сборка или Engine smoke не заполняют эти проектные ячейки.
Перед release claim привяжите эти ячейки к одному versioned artifact и добавьте
его результат install/start/runtime; реализованная payload-ветка является
capability, а не «полной поддержкой».

## Проверенные исходные пути

- `BuildTools/SupportMatrix.json`
- `BuildTools/docs_support_matrix.py`
- `BuildTools/buildtools.py`
- `BuildTools/cmake/stages/Init.cmake`
- `BuildTools/cmake/stages/Applications.cmake`
- `.github/disabled-workflows/validate.yml` (историческое определение, не активный CI)
- `Examples/MinimalProject/`
- `Examples/MinimalMultiplayer/`
- `Docs/generated/support-matrix.json`
- `Docs/ru/reference/platforms/generated-matrix.md`

## Термины поддержки

- **Build-gated** означает, что обязательный workflow конфигурирует и
  компилирует профиль при каждом изменении.
- **Smoke-gated** означает, что профиль является build-gated и дополнительно
  запускается именованный процессный маршрут starter или multiplayer.
- **Source-capable** означает, что BuildTools предоставляет профиль, но
  обязательный CI его не проверяет.
- **Project-qualified** означает, что игровой проект добавил необходимые для
  своего релиза проверки runtime, упаковки, оборудования, службы или магазина.
  Engine CI не может сделать такое заявление за игру.
- **Unsupported for release** означает, что у проекта нет ни Engine build
  gate, ни собственного сопровождаемого маршрута приёмки.

Эти метки намеренно уже, чем «работает на моей машине». Успешная
кросс-компиляция не доказывает, что откроется окно, устройство корректно
возобновит работу, браузер подключится, renderer заработает на пользовательских
драйверах или подписанный пакет установится.

## Текущая база форка

GitHub Actions отключены в этом workspace. Workflow в
`.github/disabled-workflows/` — архив, а не действующий gate или доказательство
успешной сборки текущей ревизии. Все профили текущей матрицы имеют уровень
**source-capable**. Архивные списки целей сохраняют историческую конфигурацию
отдельно от доступных локальных целей BuildTools; ни один список не является
результатом запуска. Перенос локального workflow не менял настройки remote.

Примеры Engine сохраняют необязательные локальные validators для minimal
headless project, tutorial multiplayer flow, native extensions, packaging и
Content Showcase. Запускайте нужный существующий маршрут и указывайте точную
ревизию, конфигурацию, результат и ограничения. Unit suites удалены; не
включайте удалённые test/coverage options.

Видимый rendering, audio, signing/installers, persistence backends, публичная
сеть и длительная работа службы остаются приёмкой проекта. Датированный
результат upstream или внешнего проекта не квалифицирует этот форк.

## Границы приложений

Desktop-сборки могут предоставлять больше приложений, чем мобильные и Web.
Публичная mobile/Web-матрица покрывает только client path. Не считайте server,
mapper, baker, compiler, service или daemon поддерживаемыми на этих целях лишь
потому, что там компилируется общий исходный код.

Создание приложений находится в `BuildTools/cmake/stages/Applications.cmake`,
локальные validation names — в `BuildTools/buildtools.py`. Архивный workflow
фиксирует прежний выбор; действующих обязательных целей CI нет.

Универсальная цель Editor удалена. Для интерактивного редактирования карт
используется Mapper, а для просмотра анимаций и частиц — отдельные viewers.
После удаления соответствующей BuildTools-цели обязательный CI не должен
сохранять validation names вида `*-editor`.

## Границы renderer

Наличие backend во время компиляции не означает визуальную квалификацию:

- Windows, Linux и macOS компилируют платформенный OpenGL path и могут включать
  Vulkan и SDL_GPU, если они явно не отключены.
- Android и iOS компилируют мобильные платформенные возможности; приёмка на
  устройстве всё равно обязательна.
- Web использует WebGL 2. Платформенная стадия исключает Vulkan и SDL_GPU.
- Headless smoke-тесты намеренно не доказывают ни наличие пикселей, ни слышимый
  вывод.

Каждая игра, выпускающая renderer, должна сопровождать представительную
видимую сцену для каждого поддерживаемого семейства GPU/платформ. Проверяйте
startup, map load, resize/orientation где применимо, device loss или
background/resume где применимо, а также хотя бы по одному используемому
продуктом пути effect, font, image, model или sprite и GUI.

## Матрица релиза проекта

Игровой проект должен копировать модель доказательств, а не эту таблицу. Для
каждой выпускаемой комбинации записывайте:

| Измерение | Обязательное доказательство проекта |
|---|---|
| Host и compiler | Чистые configure/build на закреплённой ревизии Engine |
| Client platform и architecture | Установка или запуск на представительном оборудовании/runtime |
| Server platform | Жизненный цикл процесса/службы, database, backup, restore, logs и graceful shutdown |
| Renderer | Видимая сцена и покрытие drivers/devices |
| Networking | Native или WebSocket transport, reconnect, timeout и compatibility behavior |
| Packaging | Воспроизводимый package, аудит содержимого, signing/notarization/store route |
| Localization | Bake, покрытие glyph, layout, input и переключение языка |
| Updater | Точная совместимость protocol/ABI и политика rollback/reinstall |

Проект может повысить профиль только после того, как эти gates станут
версионируемыми и повторяемыми. Временная ручная проверка полезна как
доказательство, но не равна сопровождаемой поддержке. Используйте
[Упаковку и выпуск](../../how-to/release/packaging.md), чтобы превратить строку
packaging в проверяемую проектную процедуру и acceptance lane.

## Добавление или изменение профиля

1. Добавьте или измените реальную validation target в
   `BuildTools/buildtools.py`.
2. Не включайте CI ради ремонта документации. Будущий build gate требует явно
   разрешённого активного workflow и наблюдаемого исполнения.
3. Обновите `BuildTools/SupportMatrix.json`, указав самое узкое правдивое
   значение level.
4. Выполните:

   ```bash
   python BuildTools/docs_support_matrix.py --write
   python BuildTools/docs_support_matrix.py --check
   ```

5. Обновите platform how-tos и release matrix игрового проекта, если изменились
   поведение или prerequisites.
6. Не повышайте `source_capable` до `build_gated` без обязательного CI, а
   `build_gated` до `smoke_gated` без исполняемого маршрута.

## Сопровождение

Сгенерированная модель проверяет локальные цели по актуальному реестру,
исторические — по архиву и отклоняет заявления об активном gate на основании
архивного workflow. Она не
может вывести качество runtime из факта компиляции, поэтому runtime evidence и
ограничения остаются проверяемым policy text.

При обновлении Engine или игрового проекта проверяйте весь входящий диапазон на
изменения platform detection, минимальных toolchains, создания приложений,
BuildTools validation profiles, workflow runners, renderer gates, package
support и updater boundaries. Обновляйте эту матрицу в том же изменении.
