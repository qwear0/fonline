---
title: Сгенерированный справочник audio
document_id: generated-audio-index
locale: ru
generated: true
---

<!-- docs-translation: {"document_id":"generated-audio-index","locale":"ru","source_path":"Docs/en/reference/audio/index.md","source_sha256":"c79880f2903d199e8df53c783fe48df1a0bef5b738b47b2643dbeeeabae5eb6c"} -->

# Сгенерированный справочник audio

> Сгенерированный справочник. Не редактируйте его источник напрямую. Обновите `BuildTools/AudioInterface.json`, затем выполните `python BuildTools/docs_audio.py --write`.

[Индекс](index.md) | [Форматы](formats.md) | [Доставка](delivery.md) | [Декодирование](decoding.md) | [Воспроизведение](playback.md) | [Проверка](validation.md) | [Канонический JSON](../../../generated/audio.json) | [Руководство](../../how-to/content/audio.md)

Этот справочник описывает принадлежащие Engine доставку аудиоресурсов, декодирование, воспроизведение, микширование и точки входа скриптов. Каталоги звуков проекта, пространственная политика, автоматы состояний музыки, мастеринг и лицензирование находятся вне этого контракта.

## Статус контракта

| Поле | Значение |
| --- | --- |
| Стабильность | <code>experimental</code> |
| Политика поддержки | Модель проверяет актуальные source anchors и выведенные константы аудио. Запекание ресурсов и слышимый запуск клиента — отдельные проектные проверки; собственных unit suites движка в этом форке нет. |
| Исходный манифест | [BuildTools/AudioInterface.json](https://github.com/cvet/fonline/blob/master/BuildTools/AudioInterface.json) |
| Digest контракта | <code>75b4620055b71a9794fec35ac35fa953a1cf4778f67937acc320148fa88c7108</code> |
| Runtime-форматы | <code>.ogg</code> |
| Missing-suffix fallback | no |
| Сторона выполнения | <code>client</code> |

| Справочник | Записи | Назначение |
| --- | --- | --- |
| [Форматы](formats.md) | 3 | Допустимые контейнеры/кодеки и роли источников. |
| [Доставка](delivery.md) | 5 | Audio baking, authored paths, indexing, and payload rules. |
| [Декодирование](decoding.md) | 8 | Ограничения форматов, streaming, преобразование и микширование. |
| [Воспроизведение](playback.md) | 10 | Script methods, sound handles, placement, music, repeat, and volume. |
| [Проверка](validation.md) | 7 | Поведение при ошибках и границы проверки. |

## Граница

Включено:

- авторские входы WAV и нативные ресурсы Ogg Vorbis, принимаемые AudioBaker
- доставка через AudioBaker и индексирование путей ресурсов в AudioManager
- декодирование, преобразование, streaming, микширование, позиционирование, повтор и остановка в AudioManager
- клиентские script entry points Game.PlaySound, Game.UpdateSound и Game.PlayMusic
- настройки аудио, headless-поведение, диагностика и границы проектной проверки

Исключено:

- проектные каталоги звуков, сопоставления понятий с путями, выбор вариантов, автоматы состояний музыки, выбор ambient и политика пространственного звука
- запись, голосовой чат, устройства захвата, DSP-графы, шины, ducking и авторские кривые attenuation
- целевые параметры мастеринга, политика loudness, лицензирование, атрибуция и происхождение исходников
- звуковые узлы Effekseer, которые не поддерживаются средой выполнения Effekseer в FOnline
- видеоконтейнеры и связанный с видео звук
