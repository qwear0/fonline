---
layout: default
title: Публикация сайта документации
locale: ru
document_id: documentation-site-publication
permalink: /Docs/ru/contributing/documentation/site-publication.html
---
<!-- docs-translation: {"document_id":"documentation-site-publication","locale":"ru","source_path":"Docs/en/contributing/documentation/site-publication.md","source_sha256":"8e4a88ef1a97c50d9fba6cd6358584d58cb723d49dfa785c9c681a8c02040037"} -->

# Публикация сайта документации

Это руководство владеет локальной подготовкой, рендерингом, ревью и предпосылками отдельно разрешённой публикации. Канонический источник — Markdown репозитория; не создавайте второе дерево авторского сайта.

## Проверенные исходные пути

- `Docs/documentation-manifest.json`
- `Docs/Site/_config.yml`
- `Docs/Site/Layouts/default.html`
- `Docs/Site/Assets/css/docs.css`
- `Docs/Site/Assets/js/docs.js`
- `BuildTools/documentation_metadata.py`
- `BuildTools/docs_prepare.py`
- `BuildTools/docs_site_build.py`
- `BuildTools/docs_site.py`
- `BuildTools/docs_site_artifact.py`
- `BuildTools/docs-browser/audit.mjs`
- `BuildTools/docs-browser/package.json`
- `BuildTools/DocumentationDiagrams.json`
- `BuildTools/DocumentationScreenshots.json`
- `.github/disabled-workflows/validate.yml`

## Контракт production

Этот checkout — форк `qwear0/fonline`. Его workflows архивированы в `.github/disabled-workflows/` и не предоставляют активного CI, артефактов pull request или автоматического deployment. Локальный перенос файлов не меняет удалённые настройки. Источник публикации и владение DNS для форка не проверены: manifest фиксирует ожидающую проверку источника и ненаблюдавшееся состояние DNS. `fonline.ru` — унаследованная конфигурация URL/домена, а не заявление о владении или публикации форком. Сгенерированный `CNAME` задаёт конфигурацию, но не доказывает владение.

Архивный upstream workflow описывает артефакт `documentation-site` и зависимый master-only job `documentation-publish`, ограниченный `cvet/fonline`. Это исторический проект процесса, не включённый маршрут публикации форка. Не активируйте его, не загружайте артефакты и не меняйте Pages/DNS без отдельного разрешения владельца.

| Предмет | Владелец или локальный контракт |
|---|---|
| Каноническое содержимое | Версионируемые Markdown и проверенные EN/RU-переводы |
| Рендерер | Jekyll, совместимый с GitHub Pages |
| URL, репозиторий, домен, pins | `publishing` в `Docs/documentation-manifest.json` |
| Конфигурация сайта | `Docs/Site/_config.yml` |
| Оболочка рендеринга | `Docs/Site/Layouts/default.html`, локальные CSS/JavaScript/assets |
| Навигация/поиск/маршруты | `BuildTools/docs_site.py` по стабильным ID manifest |
| Учебные диаграммы | `DocumentationDiagrams.json`, генерируемые desktop/mobile SVG и каталог происхождения |
| Скриншоты инструментов | `DocumentationScreenshots.json`, проверенные PNG и каталог происхождения |
| Результат ревью | Локальные `Workspace/DocumentationSite/` и отчёты, привязанные к точному состоянию |
| Live-публикация | Принадлежит администраторам, отдельно разрешается и проверяется |

## Владение исходниками сайта

`Docs/Site/Layouts/` владеет HTML-оболочкой, `Data/` — генерируемой навигацией, `Assets/` — стилями, JavaScript, брендингом и поиском локалей. Исходники layout/data исключены из публикации; URL assets сохраняют `/Docs/Site/Assets/`. Managed-деревья `bin`/`obj` любой глубины, приватная/внутренняя документация, зависимости и локальные сборки должны оставаться исключёнными. `docs_site_artifact.py` отклоняет утечки внутренних страниц/моделей и отсутствие публичных assets.

`docs_prepare.py` записывает игнорируемые входы доставки по зависимостям; он не перегенерирует версионируемые публичные модели, Markdown, SVG или PNG. Он выводит `Gemfile`, `.ruby-version` и `CNAME` в `Workspace/Documentation/` из pins/домена manifest. Конфигурация Bundler и `Gemfile.lock` также находятся там. Локальные логические корневые endpoints `llms.txt`, `llms-full.txt`, `docs-manifest.json` размещаются в этом каталоге. `docs_site_build.py` подготавливает входы, рендерит `Workspace/DocumentationSite/` и копирует endpoints и `CNAME` в корень результата. Локальное размещение не меняет публичные пути URL.

Layout включает корневой `VERSION` стандартным Jekyll include с `includes_dir: .`. Публикуйте `/VERSION` побайтно рядом с `/docs-manifest.json` только при разрешённой завершённой доставке. Не копируйте литерал версии в layout или модель маршрутов. Плавающий канал документации — `current`/`master`, не стабильный выпуск; снимки `/versions/{version}/` отложены до появления поддерживаемых неизменяемых tags и политики.

<figure class="docs-diagram">
<picture>
<source media="(max-width: 700px)" srcset="../../../assets/diagrams/documentation-delivery-mobile.svg">
<img src="../../../assets/diagrams/documentation-delivery.svg" alt="Схема доставки документации. Канонические Markdown и manifest поступают в детерминированные генераторы. Навигация, поиск, маршруты, пакеты ИИ и отчёты создаются до сборки сайта; проверенные изображения диаграмм версионируются. Jekyll собирает сайт для людей, а клиенты ИИ используют llms.txt, llms-full.txt, docs-manifest.json и generated JSON. Статические, браузерные, accessibility-, hash- и freshness-проверки относятся к одной ревизии." loading="lazy">
</picture>
<figcaption>Маршруты людей и ИИ — проекции одного версионируемого Markdown-корпуса. Локальный сайт, машинные endpoints и свидетельства ревью должны использовать одинаковые manifest, артефакты, ревизию исходников и хэши содержимого.</figcaption>
</figure>

Публичные README закрепляют `.html` permalinks из manifest, чтобы `jekyll-readme-index` не заменял их индексами каталогов. Обычный `index.md` использует URL каталога с артефактом `/path/index.html`. Долговечные Markdown-указатели сохраняют старые маршруты/якоря. У канонической цели может быть только один владелец не с `replace`; локали объединяет стабильный ID, не перевод заголовка. См. [перевод](translation.md) и [сопровождение документации](index.md).

## Навигация и статический поиск

Layout репозитория предоставляет desktop sidebar, mobile drawer, оглавление, source links, копирование кода, тему, версию Engine и EN/RU-переключатель. Технической прозой он не владеет. Каждая публичная/current/human верхнеуровневая страница включена в навигацию один раз; generated detail pages доступны поиску через свои индексы. Внутренние планы и placeholders исключены.

`Docs/Site/Data/docs-site.json` содержит идентичность, локализованную навигацию, маршруты и пары локалей. `Docs/Site/Assets/docs-search.json` и `docs-search.ru.json` содержат только текущие публичные страницы для людей своей локали. `docs-manifest.json#/routing` содержит текущие/планируемые маршруты, доступность локалей, каноническое владение и redirects. Локализация владеет `#/translation_status` в том же общем индексе; writers сохраняют остальные разделы.

Поиск использует локальные JavaScript/browser APIs без внешнего поискового сервиса или remote script. Заголовки важнее основного текста; полные technical identifiers и camel-case components остаются searchable. Чисто числовые компоненты и термины более чем в 60% корпуса локали исключены как неразличающие. Аннотации ограничены 224 символами вместе с многоточием, с обрезкой по слову. У каждого компактного UTF-8 индекса жёсткий бюджет 1 867 776 байт; переполнение завершает генерацию ошибкой, не удалением документов. Скрытые комментарии перевода и пустые anchors вне кода не индексируются; видимый текст и буквальные примеры markup сохраняются.

## Маршруты ИИ и машинные данные

Унаследованные логические маршруты включают `/llms.txt`, `/llms-full.txt`, `/docs-manifest.json`, его routing/translation-разделы и generated model/evaluation/snippet/diagram/screenshot JSON под `/Docs/generated/`. Локальная генерация не доказывает доступность endpoints в сети. Доставка ИИ записывает stable IDs, владельцев, состояние, canonical/source/raw URL, происхождение, нормализованные LF-хэши и байты. Source links используют repository/ref manifest; полный контекст включает авторские страницы и generated indexes без дублирования огромных API-таблиц. Превышение бюджета требует ревью владельца, не усечения. GitHub Pages/Jekyll не создаёт same-domain raw Markdown aliases без дополнительного механизма публикации; не обещайте такие aliases.

Сначала перегенерируйте затронутые версионируемые модели/справочники, затем диаграммы/скриншоты, snippets, локализацию, site/search/routes, AI evaluation и последней AI delivery. Итоговый публичный manifest хэширует окончательные входы. См. [проверку snippets](snippets.md) и [оценку ИИ](ai-evaluation.md).

## Подтверждённое публичное состояние

Историческое upstream-свидетельство не является текущим свидетельством форка. Унаследованный отчёт фиксирует публичные проверки 2026-07-10, 2026-07-15 и 2026-08-01 и аутентифицированное наблюдение Pages `cvet/fonline` 2026-08-02: legacy-ветка `master` в `/`, `fonline.ru`, включённый HTTPS, доступные root/legacy routes и тогда ещё неопубликованные EN/RU routes с 404. Записаны успешная upstream-сборка `fee50fb636b5bd1e30509aded929df1fc0e95db5`, IPv4 DNS GitHub Pages и отсутствие наблюдавшегося TXT `_github-pages-challenge-cvet.fonline.ru`. Поздняя унаследованная заметка 2026-10-09 фиксирует выбор Actions source, но первый deployment нового workflow не проверен. Это датированные наблюдения другого репозитория, не live-заявления и не инструкции менять удалённое состояние.

Обновляйте source/DNS-состояние форка в manifest только по разрешённым authenticated settings/API evidence и публичному DNS. Отрендеренная страница или generated `CNAME` не доказывают владение доменом. Credentials, registrar accounts, recovery codes и приватные операционные личности не входят в публичные свидетельства.

## Совместимая среда

Manifest фиксирует Ruby `3.3.4` и `github-pages` `232`; игнорируемый Gemfile lock не заменяет эту границу совместимости. Windows Ruby требует Devkit/MSYS2 для native gems. Браузерные инструменты фиксируют Node `24.16.0`, Playwright `1.62.0`/Chromium `151.0.7922.34` и axe-core `4.12.1` через manifest и npm lock. Подготавливайте зависимости отдельно с разрешением; правка документации не разрешает установку. Смена pins требует согласования lock и полных затронутых render/browser-проверок, не `latest` или снижения порогов.

## Локальная сборка и просмотр

Из корня Engine, когда все зависимости уже доступны и выходные пути разрешены:

```bash
python BuildTools/docs_prepare.py --external
python BuildTools/docs_site_build.py
python BuildTools/docs_site_artifact.py --site-dir Workspace/DocumentationSite
npm --prefix BuildTools/docs-browser run audit
```

Подготовка может упасть после частичной записи; не считайте последующие артефакты завершённой сборкой. Требуйте отсутствие Jekyll/Liquid errors и строгий front matter. Browser audit обслуживает только готовое локальное дерево на ephemeral loopback port, пишет JSON/screenshots под `Workspace/`, не обращается к production и не выполняет snippets. Для интерактивного просмотра:

```bash
python -m http.server 4000 --bind 127.0.0.1 --directory Workspace/DocumentationSite
```

Остановите сервер до смены ревизии или pins зависимостей.

## Артефакт pull request

В форке не обещается автоматический артефакт pull request. Сохраняйте локальный результат ревью, static report, browser report и screenshots с точной ревизией и идентичностью грязных входов, pins зависимостей, командами и кодами завершения. Все проверки должны потреблять одно завершённое дерево.

Статическая проверка требует каждый current/available-locale route, побайтно одинаковые static endpoints, правильные canonical URL и HTML language, один `h1`, skip/main landmarks, accessible image/button names, unique IDs, search targets и правильные ссылки на публикуемые ресурсы.

Browser gate проверяет каждый route в desktop 1440 x 1000, mobile 390 x 844 и `zoom-200` 640 x 512 CSS pixels с device scale factor 2 (1280 x 1024 физических). Последний профиль моделирует 200-percent reflow без mobile user agent. Не допускаются выбранные WCAG 2.2 A/AA axe violations, page/console/request failures, undecoded images, обрезанные колонки, overlap fixed header/sidebar и достижимое переполнение страницы. У code blocks остаётся собственная горизонтальная прокрутка; длинная проза переносится. Instant-scroll probes не позволяют smooth scrolling скрывать overflow.

Interactions охватывают skip navigation, EN/RU search, dialog Escape, сохранение темы, copy feedback, удержание/восстановление focus compact drawer, `html lang`, явные README-пары, точное переключение локали, architecture/gallery media и русский 200-percent reflow. Декодирование изображений завершается до измерений/съёмки. Профили используют отдельные browser contexts; сохраняйте порядок profiles и запускайте interactions после всех routes. Просматривайте каждый screenshot, включая `zoom-200-russian-documentation.png`, и изменённые страницы интерактивно.

Axe incomplete nodes остаются явными ограниченными rule/route records. Для clipped scroll-container `color-contrast` существующий audit вычисляет effective alpha-composited colors, использует WCAG relative luminance и требует 4.5:1 либо 3:1 для крупного текста. Failed или unresolvable fallback проваливает проверку; не переименовывайте incomplete в passed. Автоматизация не доказывает screen-reader behavior, ясность для понимания, все браузеры/шрифты/magnifiers или соответствие production. Для release review нужны также keyboard-only, representative assistive-technology и landed-environment 200-percent zoom observations.

## Проверка production

Только после отдельно разрешённой публикации подтвердите выбранный администратором источник и deployed commit, сохраните соответствующие локальные отчёты/артефакты, проверьте root/EN/RU/legacy routes, навигацию, язык, поиск локали, HTTPS, точный `CNAME` и DNS. Передавайте расхождения администраторам репозитория/домена; не коммитьте generated HTML, не изобретайте другой deployment workflow, не ослабляйте HTTPS и не заявляйте владение форка унаследованным доменом.

## Контрольный список

Требуйте свежие проверки затронутых model/reference, diagram/screenshot, snippet, localization, site, AI-evaluation/delivery и `docs_validate.py`; удалённые unit-наборы не являются предпосылками. Отдельно требуйте завершённую сборку Jekyll, static artifact check, закреплённый browser audit, visual/keyboard/assistive review в пределах заявляемой приёмки и точную идентичность сохранённого результата. Честно фиксируйте отсутствующие зависимости и сбои. Локальная проверка никогда не разрешает и не доказывает публикацию.
