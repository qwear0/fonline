---
title: Particle Validation Contract
document_id: generated-particle-format-validation
locale: en
generated: true
---

# Particle Validation Contract

> Generated reference. Do not edit this page directly. Update `BuildTools/ParticleFormatInterface.json`, then run `python BuildTools/docs_particle_format.py --write`.

[Reference index](index.md) | [Source rules](xml.md) | [Formats and backends](objects.md) | [Rendering](renderer.md) | [Tooling](tooling.md) | [Runtime](runtime.md) | [Integration](integration.md) | [Validation](validation.md) | [Canonical JSON model](../../../generated/particle-format.json) | [Guide](../../how-to/content/particle-format.md) | [Authoring tools](../../how-to/tools/particle-authoring.md)

| Stable ID | Gate | Requirement | Why | Source |
| --- | --- | --- | --- | --- |
| <a id="entry-particle-format-validation-documentation-7546671f20"></a><code>particle-format.validation.documentation</code> | Documentation contract | Run docs_particle_format.py --check and its focused unit test after changing particle formats, backends, tools, or integrations. | The manifest validates every source anchor and generated page. | [BuildTools/ParticleFormatInterface.json](https://github.com/cvet/fonline/blob/master/BuildTools/ParticleFormatInterface.json) |
| <a id="entry-particle-format-validation-baker-tests-f3527f22eb"></a><code>particle-format.validation.baker-tests</code> | Particle bake checks | Rebake representative resources for each enabled backend after changing formats, transforms, path checks, compiler output, or dependency invalidation; inspect diagnostics and runtime output. | Engine-owned unit suites are retired. Documentation checks do not execute the backend bake boundaries. | [Source/Tools/ParticleBaker.cpp](https://github.com/cvet/fonline/blob/master/Source/Tools/ParticleBaker.cpp) |
| <a id="entry-particle-format-validation-effekseer-runtime-cf357090ac"></a><code>particle-format.validation.effekseer-runtime</code> | Effekseer runtime verification | Inspect a baked effect in Mapper or ParticleViewer and a representative client scene after changing geometry, sorting, batching, textures, seed, or scale. Keep Effekseer look direction at zero. | The authoring editor and source checks do not exercise FOnline callback rendering or prove gameplay integration. | [Source/Client/EffekseerExtension.cpp](https://github.com/cvet/fonline/blob/master/Source/Client/EffekseerExtension.cpp) |
| <a id="entry-particle-format-validation-project-bake-277a4e8ee2"></a><code>particle-format.validation.project-bake</code> | Embedding-project bake | Rebake an affected embedding project and reject authored .spk/.efk, malformed sources, missing dependencies, and stale generated resources. | Only the project bake sees its complete resource graph and feature selection. | [Source/Tools/ParticleBaker.cpp](https://github.com/cvet/fonline/blob/master/Source/Tools/ParticleBaker.cpp) |
| <a id="entry-particle-format-validation-visible-scene-6c56437d52"></a><code>particle-format.validation.visible-scene</code> | Visible runtime validation | Inspect every affected backend and integration route in Mapper and a representative client scene, including depth, clipping, lifetime, transforms, and performance. | Successful compilation cannot prove visual correctness or gameplay timing. | [Source/Tools/ParticleEditor.cpp](https://github.com/cvet/fonline/blob/master/Source/Tools/ParticleEditor.cpp) |
| <a id="entry-particle-format-validation-render-routes-20fe741d3d"></a><code>particle-format.validation.render-routes</code> | Both render routes | Visibly check atlas particles and direct-scene particles at their real draw order, camera angle, scale, depth occluders, and supported renderer backends. | Headless parsing cannot prove framing, alpha, blend, depth, orientation, or world-scale behavior. | [Source/Client/ParticleSprites.cpp](https://github.com/cvet/fonline/blob/master/Source/Client/ParticleSprites.cpp)<br>[Source/Client/SparkExtension.cpp](https://github.com/cvet/fonline/blob/master/Source/Client/SparkExtension.cpp) |
| <a id="entry-particle-format-validation-model-route-e7787fd80a"></a><code>particle-format.validation.model-route</code> | Model attachment route | For AttachParticles or Critter.RunParticle changes, visibly verify the target bone, offset, active layer lifetime, animation, and FO_ENABLE_3D profile. | An isolated particle preview does not exercise model-bone ownership or gameplay projection. | [Source/Client/ModelInstance.cpp](https://github.com/cvet/fonline/blob/master/Source/Client/ModelInstance.cpp) |

## Validation commands

```powershell
python BuildTools\docs_particle_format.py --check
```

An embedding project must also rebake its resources and visibly inspect every affected backend and integration route.
