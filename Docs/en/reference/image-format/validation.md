---
title: Image Format Validation
document_id: generated-image-format-validation
locale: en
generated: true
---

# Image Format Validation

> Generated reference. Do not edit directly. Update `BuildTools/ImageFormatInterface.json`, then run `python BuildTools/docs_image_format.py --write`.

[Index](index.md) | [Formats](formats.md) | [FOFRM](fofrm.md) | [Options](options.md) | [Baking](baking.md) | [Runtime](runtime.md) | [Validation](validation.md) | [Canonical JSON](../../../generated/image-format.json) | [Guide](../../how-to/content/image-format.md)

| Stable ID | Rule | Requirement | Why | Source |
| --- | --- | --- | --- | --- |
| <a id="entry-image-format-validation-fofrm-count-068d95fc54"></a><code>image-format.validation.fofrm-count</code> | Positive FOFRM count | Reject a descriptor whose count/Count is zero or negative. | A descriptor must resolve at least one source reference before a runtime frame table can exist. | [Source/Tools/ImageBaker-Fofrm.cpp](https://github.com/cvet/fonline/blob/master/Source/Tools/ImageBaker-Fofrm.cpp) |
| <a id="entry-image-format-validation-fofrm-directions-55fce0e5eb"></a><code>image-format.validation.fofrm-directions</code> | Complete equal-size directions | A missing direction-one section or missing direction-one frame reference ends loading as single-direction; later authored directions are then not examined. Once later directions are reached, missing sections or frame-count mismatches fail. Author either one direction or the complete map direction set. | Every direction sheet shares one frame-count and timing header. | [Source/Tools/ImageBaker-Fofrm.cpp](https://github.com/cvet/fonline/blob/master/Source/Tools/ImageBaker-Fofrm.cpp) |
| <a id="entry-image-format-validation-fofrm-nested-shared-106e8e7e2a"></a><code>image-format.validation.fofrm-nested-shared</code> | No nested shared frame records | Reject a FOFRM reference whose child Main frame is already a shared record. | The flattening implementation copies concrete child pixels and does not rebase child shared indices. | [Source/Tools/ImageBaker-Fofrm.cpp](https://github.com/cvet/fonline/blob/master/Source/Tools/ImageBaker-Fofrm.cpp) |
| <a id="entry-image-format-validation-rgba-payload-a6560c29d9"></a><code>image-format.validation.rgba-payload</code> | Exact RGBA payload size | Reject every concrete frame whose byte payload is not exactly width times height times four. | The client reads a fixed RGBA8 byte count without a separate payload-length field. | [Source/Tools/ImageBaker.cpp](https://github.com/cvet/fonline/blob/master/Source/Tools/ImageBaker.cpp) |
| <a id="entry-image-format-validation-tga-subset-87f4c5c869"></a><code>image-format.validation.tga-subset</code> | Supported TGA subset | Use no image ID, bottom-left orientation, TrueColor type 2 or 10, and 24 or 32 bpp; indexed/grayscale/other inputs are rejected or outside the implemented orientation assumptions. | The loader consumes the fixed header directly, then always flips rows and does not branch on descriptor origin. | [Source/Tools/ImageBaker-Tga.cpp](https://github.com/cvet/fonline/blob/master/Source/Tools/ImageBaker-Tga.cpp) |
| <a id="entry-image-format-validation-malformed-inputs-e15cbd5a50"></a><code>image-format.validation.malformed-inputs</code> | Malformed decoder inputs | Bake the changed image inputs and inspect decoder diagnostics. Do not treat successful documentation generation as execution of PNG, TGA, legacy, SPR, or nested FOFRM parsers. | Legacy binary parsers must fail deterministically instead of emitting truncated runtime containers. | [Source/Tools/ImageBaker.cpp](https://github.com/cvet/fonline/blob/master/Source/Tools/ImageBaker.cpp) |
| <a id="entry-image-format-validation-runtime-container-b6aaaecb88"></a><code>image-format.validation.runtime-container</code> | Runtime container guards | Reject invalid header/footer magic, zero frames, zero directions, unsupported direction counts, invalid single-frame shared records, and invalid shared-frame indices. | Corrupt baked bytes must not reach atlas allocation or animation updates. | [Source/Common/SpriteResource.cpp](https://github.com/cvet/fonline/blob/master/Source/Common/SpriteResource.cpp), [Source/Client/DefaultSprites.cpp](https://github.com/cvet/fonline/blob/master/Source/Client/DefaultSprites.cpp) |
| <a id="entry-image-format-validation-playback-timing-f10375614b"></a><code>image-format.validation.playback-timing</code> | Nonzero per-frame duration | For a playing multi-frame sheet, author timing so whole AnimTicks divided by flattened frame count is at least one millisecond; fps zero intentionally disables playback. | SpriteSheet::Update divides elapsed time by integer ticks_per_frame, while Play only guards one frame or zero whole ticks. | [Source/Client/DefaultSprites.cpp](https://github.com/cvet/fonline/blob/master/Source/Client/DefaultSprites.cpp) |
| <a id="entry-image-format-validation-project-visible-c586865990"></a><code>image-format.validation.project-visible</code> | Embedding-project visual gate | After native and documentation checks, rebake the embedding project and inspect changed dimensions, alpha edges, mirrors, directions, cadence, offsets, hit masks, and relevant client profiles in a visible scene. | Source-derived documentation checks cannot prove art framing, filtering, gait, or project resource-pack selection. | [Source/Client/SpriteManager.cpp](https://github.com/cvet/fonline/blob/master/Source/Client/SpriteManager.cpp) |

## Validation commands

```powershell
python BuildTools\docs_image_format.py --check
```

An embedding project must also rebake affected resources and inspect every changed animation, direction, alpha edge, hit mask, and supported client profile.
