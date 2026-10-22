# Ресурсы FOnline Engine
<!-- docs-translation: {"document_id":"engine-resources-readme","locale":"ru","source_path":"Resources/README.md","source_sha256":"6d7d0da96cd72613ff3812134ea873fc7f89f5766357231229d6e5016489571e"} -->

Этот каталог содержит переиспользуемые ресурсы Engine, а не каталог ресурсов
игры. `Core/` предоставляет стандартные эффекты, шрифты и общий контент.
`Embedded/` содержит bootstrap-ресурсы, нужные до готовности обычных ресурсов
проекта. Значки платформ и входы resource compiler также остаются build inputs.

Не добавляйте произвольные ZIP в `Embedded/` в расчёте на автоматическую
доставку. В корне репозитория нет `CMakeLists.txt` и поддерживаемой процедуры
`CreateResources`. Встраивающий проект объявляет resource packs в `.fomain`,
выбирает input directories, filters, bakers и runtime sides, затем запускает
`BakeResources` или `ForceBakeResources` из настроенного project output.
Упаковка выбирает запечённые ресурсы по проектному package contract.

- [Конфигурация проекта](../Docs/ru/how-to/build/project-configuration.md)
- [Конвейер запекания](../Docs/ru/explanation/content-pipeline/baking.md)
- [Упаковка](../Docs/ru/how-to/release/packaging.md)
- [Владение генерируемым содержимым](../Docs/ru/how-to/build/generated-content.md)

Проектные изображения, звуки, модели, скрипты, лицензии, происхождение и
свидетельства приёмки храните в проекте. Успех копирования или запекания не
доказывает визуальную или звуковую корректность: проверьте затронутый путь
клиента/инструмента на каждой заявленной платформе. Генерируемый выход
исправляется в авторском источнике.
