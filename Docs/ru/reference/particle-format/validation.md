---
title: Контракт проверки частиц
document_id: generated-particle-format-validation
locale: ru
generated: true
---

<!-- docs-translation: {"document_id":"generated-particle-format-validation","locale":"ru","source_path":"Docs/en/reference/particle-format/validation.md","source_sha256":"d65d3549161fcc14c5568b7ba2e82a27e10010dc559bb11c92ada7f94f6c1b3a"} -->

# Контракт проверки частиц

> Сгенерированный справочник. Не редактируйте эту страницу напрямую. Обновите `BuildTools/ParticleFormatInterface.json`, затем выполните `python BuildTools/docs_particle_format.py --write`.

[Индекс справочника](index.md) | [Правила исходников](xml.md) | [Форматы и backend-ы](objects.md) | [Отрисовка](renderer.md) | [Инструменты](tooling.md) | [Runtime](runtime.md) | [Интеграция](integration.md) | [Проверка](validation.md) | [Каноническая JSON-модель](../../../generated/particle-format.json) | [Руководство](../../how-to/content/particle-format.md) | [Инструменты авторинга](../../how-to/tools/particle-authoring.md)

| Стабильный ID | Gate | Требование | Причина | Источник |
| --- | --- | --- | --- | --- |
| <a id="entry-particle-format-validation-documentation-7546671f20"></a><code>particle-format.validation.documentation</code> | Контракт документации | После изменения форматов частиц, подсистем, инструментов или интеграций запускайте docs_particle_format.py --check и его сфокусированный модульный тест. | Манифест проверяет каждый якорь исходника и сгенерированную страницу. | [BuildTools/ParticleFormatInterface.json](https://github.com/cvet/fonline/blob/master/BuildTools/ParticleFormatInterface.json) |
| <a id="entry-particle-format-validation-baker-tests-f3527f22eb"></a><code>particle-format.validation.baker-tests</code> | Проверки запекания частиц | После изменений форматов, transforms, проверок путей, compiler output или dependency invalidation перезапеките представительные ресурсы каждого включённого backend; проверьте диагностику и runtime-выход. | Собственные unit suites движка удалены. Проверки документации не исполняют границы запекания backend. | [Source/Tools/ParticleBaker.cpp](https://github.com/cvet/fonline/blob/master/Source/Tools/ParticleBaker.cpp) |
| <a id="entry-particle-format-validation-effekseer-runtime-cf357090ac"></a><code>particle-format.validation.effekseer-runtime</code> | Проверка runtime Effekseer | После изменений геометрии, сортировки, batching, textures, seed или scale проверьте запечённый эффект в Mapper или ParticleViewer и представительной клиентской сцене. Look direction Effekseer оставляйте нулевым. | Authoring editor и проверки исходников не выполняют callback rendering FOnline и не доказывают игровую интеграцию. | [Source/Client/EffekseerExtension.cpp](https://github.com/cvet/fonline/blob/master/Source/Client/EffekseerExtension.cpp) |
| <a id="entry-particle-format-validation-project-bake-277a4e8ee2"></a><code>particle-format.validation.project-bake</code> | Бейкинг встраивающего проекта | Повторно запеките затронутый встраивающий проект и отклоняйте авторские .spk/.efk, некорректные исходники, отсутствующие зависимости и устаревшие сгенерированные ресурсы. | Только проектный бейкинг видит полный граф ресурсов и выбранные возможности проекта. | [Source/Tools/ParticleBaker.cpp](https://github.com/cvet/fonline/blob/master/Source/Tools/ParticleBaker.cpp) |
| <a id="entry-particle-format-validation-visible-scene-6c56437d52"></a><code>particle-format.validation.visible-scene</code> | Видимая runtime-проверка | Проверяйте каждую затронутую подсистему и маршрут интеграции в Mapper и репрезентативной клиентской сцене, включая глубину, отсечение, время жизни, трансформации и производительность. | Успешная компиляция не доказывает визуальную корректность или правильное игровое время. | [Source/Tools/ParticleEditor.cpp](https://github.com/cvet/fonline/blob/master/Source/Tools/ParticleEditor.cpp) |
| <a id="entry-particle-format-validation-render-routes-20fe741d3d"></a><code>particle-format.validation.render-routes</code> | Оба маршрута рендеринга | Визуально проверяйте частицы в атласе и непосредственно в сцене с реальным порядком отрисовки, углом камеры, масштабом, перекрывающей геометрией глубины и поддерживаемыми backend-рендерерами. | Headless-разбор не доказывает правильность кадрирования, альфа-канала, смешивания, глубины, ориентации или мирового масштаба. | [Source/Client/ParticleSprites.cpp](https://github.com/cvet/fonline/blob/master/Source/Client/ParticleSprites.cpp)<br>[Source/Client/SparkExtension.cpp](https://github.com/cvet/fonline/blob/master/Source/Client/SparkExtension.cpp) |
| <a id="entry-particle-format-validation-model-route-e7787fd80a"></a><code>particle-format.validation.model-route</code> | Маршрут привязки к модели | Для изменений AttachParticles или Critter.RunParticle визуально проверяйте целевую кость, смещение, время жизни активного слоя, анимацию и профиль FO_ENABLE_3D. | Изолированный particle preview не проверяет владение привязкой к кости модели или игровую проекцию. | [Source/Client/ModelInstance.cpp](https://github.com/cvet/fonline/blob/master/Source/Client/ModelInstance.cpp) |

## Команды проверки

```powershell
python BuildTools\docs_particle_format.py --check
```

Подключаемый проект также должен повторно запечь ресурсы и визуально проверить каждый затронутый backend и маршрут интеграции.
