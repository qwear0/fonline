---
title: Video Validation Contract
document_id: generated-video-validation
locale: en
generated: true
---

# Video Validation Contract

> Generated reference. Do not edit directly. Update `BuildTools/VideoInterface.json`, then run `python BuildTools/docs_video.py --write`.

[Index](index.md) | [Formats](formats.md) | [Delivery](delivery.md) | [Decoding](decoding.md) | [Fullscreen](fullscreen.md) | [Embedded](embedded.md) | [Validation](validation.md) | [Canonical JSON](../../../generated/video.json) | [Guide](../../how-to/content/video.md)

| Stable ID | Rule | Requirement | Why | Source |
| --- | --- | --- | --- | --- |
| <a id="entry-video-validation-raw-copy-d7b856e954"></a><code>video.validation.raw-copy</code> | Delivered-byte validation | Bake and inspect the exact client resource path and bytes before runtime playback. | RawCopy is the only delivery transform and runtime paths are exact. | [Source/Tools/RawCopyBaker.cpp](https://github.com/cvet/fonline/blob/master/Source/Tools/RawCopyBaker.cpp) |
| <a id="entry-video-validation-visible-client-a82eb2ebe4"></a><code>video.validation.visible-client</code> | Visible-client requirement | Validate first frame, motion, end, skip, queue, resize, and texture cleanup in a visible client on every claimed platform. | No headless or source-only check proves texture upload and presentation. | [Source/Client/Client.cpp](https://github.com/cvet/fonline/blob/master/Source/Client/Client.cpp) |
| <a id="entry-video-validation-no-native-fixture-4621f6e513"></a><code>video.validation.no-native-fixture</code> | Runtime evidence boundary | Use direct visible playback for decoder, queue, cleanup, and loop evidence; this fork has no engine-owned unit suites. | Source anchors and documentation generation do not execute Theora decoding or texture presentation. | [Source/Client/VideoClip.cpp](https://github.com/cvet/fonline/blob/master/Source/Client/VideoClip.cpp) |
| <a id="entry-video-validation-loop-risk-6c8fa0a021"></a><code>video.validation.loop-risk</code> | Looping requires explicit proof | Do not promise looping cinematics until a multi-cycle visible regression proves decoder rewind and frame continuity for the exact asset. | SetLooped is exposed through creation, but the current source has no focused loop fixture. | [Source/Client/VideoClip.cpp](https://github.com/cvet/fonline/blob/master/Source/Client/VideoClip.cpp) |
| <a id="entry-video-validation-project-boundary-3c13a8c593"></a><code>video.validation.project-boundary</code> | Embedding-project acceptance | An embedding project owns cinematic triggers, recipients, skip/queue policy, subtitles, localization, aspect fit, audio strategy, save consequences, assets, provenance, budgets, and acceptance tests. | The Engine supplies decoder and presentation primitives, not a game cinematic system. | [Source/Scripting/ClientGlobalScriptMethods.cpp](https://github.com/cvet/fonline/blob/master/Source/Scripting/ClientGlobalScriptMethods.cpp) |

## Validation commands

```powershell
python BuildTools\docs_video.py --check
```

There is no focused native video decoder/playback fixture. A visible client must prove first frame, sustained motion, completion, skip, queue transitions, resizing, paired music behavior, cleanup, and multi-cycle looping for every exact asset and claimed platform.
