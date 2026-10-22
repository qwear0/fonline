---
layout: default
title: Generated API and Metadata
locale: en
document_id: generated-api-metadata
permalink: /Docs/en/reference/metadata/
---

# Generated API and Metadata

This guide owns the reusable source-annotation, code-generation and runtime metadata flow. The embedding project supplies its configuration, extra native metadata, scripts and content. Generated references describe those owners; they are not independent sources of behavior.

Use [Generated Content Workflow](../../how-to/build/generated-content.md) for dependency order and [Documentation Maintenance](../../contributing/documentation/) for authoring, generation and evidence policy. This fork has removed its own native, managed, Python and structural unit suites. Archived workflows are not active CI. Use existing generator checks, affected-role configure/compile/bake and direct application paths; new automated tests or test infrastructure require an explicit request.

## Ownership model

The engine owns the reusable metadata/codegen machinery. An embedding project supplies project configuration, extra metadata sources, common headers, and script/content inputs through CMake options and project files. Generated files are build artifacts: maintain source annotations, templates, generator inputs and validation flow, not generated C++ by hand.

## Source paths inspected

- `BuildTools/cmake/stages/Codegen.cmake`, `EngineSources.cmake` and `BuildTools/cmake/helpers/Build.cmake`
- `BuildTools/codegen.py`, `BuildTools/docs_api.py`, `BuildTools/docs_reference.py`
- `Source/Common/MetadataRegistration.h`, `.cpp` and `.template.cpp`
- `Source/Common/GenericCode.template.cpp`, `Properties.h` and `Properties.cpp`
- `Source/Tools/MetadataBaker.cpp`, `Source/Tools/ManagedScriptBaker.cpp`
- `Source/Scripting/Managed/ManagedInteropAbi.h` and `.cpp`
- `Docs/documentation-manifest.json`, `Docs/description-translations.ru.json`
- the model/generator pairs named below

## CMake codegen stage

`BuildTools/cmake/stages/Codegen.cmake` constructs the generator command and declared outputs. Important arguments are `-maincfg`, `-buildhash`, `-genoutput`, `-devname`, `-nicename`, `-embedded`, repeatable `-meta` and `-commonheader`, and repeatable literal `-enginedefine NAME=VALUE` entries.

`-enginedefine` carries configuration/shape macros into `EngineConfig.gen.h`; feature/backend toggles and per-configuration `FO_DEBUG` remain compiler-side. The stage creates normal/forced codegen targets and appends `CodeGeneration` to generated dependencies. `InternalConfig.gen.inc` reserves the fixed Engine-owned 20000-byte package patch area; an embedder cannot resize it.

## Generated outputs

Under the CMake binary directory's `GeneratedSource/`, codegen declares `CodeGenTouch`, `EngineConfig.gen.h`, `EmbeddedResources.gen.inc`, `InternalConfig.gen.inc`, side-specific `MetadataRegistration-*.gen.cpp` (including stubs), and `GenericCode-Common.gen.cpp`.

`EngineConfig.gen.h` carries Engine/project build identities and configuration macros; see [Engine versioning](../../how-to/release/versioning.md). Change templates, annotations and inputs, never generated C++ by hand. Baker outputs such as `ModelAnimationInfo.foinfo` are a separate resource-generation stage; [Model Animation](../../how-to/content/model-animation.md) owns its semantics.

## Canonical documentation API model

[api.json](../../../generated/api.json) is the canonical machine model for the Engine-owned native-codegen surface. `docs_api.py` opens a read-only metadata session in `codegen.py`, rather than maintaining another C++ parser. It covers enums/values, value layouts, ref types/members, entities, properties, methods, events, settings, migration rules and API contracts.

Entries carry stable `family_id`, unique `id`, kind, sides, receiver, normalized signature, flags, description, source provenance, stability/lifecycle data and explicit/default contract provenance. Arguments retain defaults, nullability and by-reference state. Overload IDs use deterministic signature hashes; a signature change can therefore appear as removal/addition.

The generated `summary`, not copied prose, owns counts, description coverage, source coverage and classification totals. Unclassified entries default to `internal`. The actual current scope classification comes from the inventory-pinned `ApiContract` in `Source/Common/Common.h`, including exact overrides; do not describe all symbols as default-internal or copy an obsolete symbol count. Reachability is not a stability promise.

Settings in one `ExportSettings` block currently share its annotation line. `command_line_redacted_by_default` records only the default command-line token-masking policy, not credential classification or secrecy.

### Source-owned symbol descriptions

Descriptions belong beside the declaration: adjacent/inline export comments, trailing enum-entry comments, and ref-type member comments. Value-layout fields use `// fieldName: description` immediately before `ExportValueType`; unknown, duplicate or empty field descriptions fail generation. Generated property-enum entries inherit their property's prose and location. Descriptions are excluded from runtime compatibility hashing; separate `ApiContract` metadata owns stability.

### API contract annotations

`///@ ApiContract <selector> <stability> ...` selects an exact ID, overload family, or `scope:native-codegen`. The scope requires current positive `SymbolCount` and a lowercase 64-hex `InventorySha256` over sorted newline-joined stable IDs. Copy both from the actual reviewed inventory, not a tutorial constant. Stale pins, unknown selectors, overlapping exact/family declarations and incomplete lifecycle fields fail generation; an exact declaration may override the one scope declaration.

`internal` has no lifecycle fields; `stable` and `experimental` require `Since`. The metadata schema can represent historical `deprecated` records with `DeprecatedSince`, live `Replacement` and `Removal`, but this is not permission to retain obsolete API aliases: [ADR-0002](../../contributing/decisions/0002-public-api-stability-contract.md) and the [current API policy](../../how-to/release/versioning.md#current-api-and-database-migrations) govern replacements. Repeated `Example` fields must name valid local paths or URLs. Contract notes do not replace symbol descriptions. Documentation-only contracts must not change runtime compatibility hashes.

Regenerate the API model, then the human projection:

```bash
python BuildTools/docs_api.py --write
python BuildTools/docs_api.py --check
python BuildTools/docs_reference.py --write
python BuildTools/docs_reference.py --check
```

## Generated Markdown reference

The [native script API reference](../script-api/index.md) renders the canonical JSON into methods, properties, events, types, settings and migration pages. `Docs/generated/api/*.md` are durable legacy routes. The renderer does not infer absent descriptions or invent another inventory. Repair source/parser/model ownership first; never patch a malformed generated table directly. Russian model prose comes through reviewed `Docs/description-translations.ru.json`, not English fallback or a hash-only update. See [Translation Workflow](../../contributing/documentation/translation.md).

## Generated contract domains

The [Public Contract Index](../public-contract/index.md) owns the current domain inventory and stability labels. Use its generated models for counts and exact records. The following routes identify production owners, not removed test prerequisites.

| Domain | Authored owner / live authority | Generator | Human reference |
| --- | --- | --- | --- |
| CMake | `BuildTools/cmake/ProjectInterface.json`; `Init.cmake`, stages/helpers | `docs_cmake.py` | [CMake](../cmake/index.md) |
| Main CLI | `buildtools.py::create_parser()` | `docs_cli.py` | [BuildTools](../buildtools/index.md) |
| Helper CLI | `HelperCliInterface.json`; executable parser factories | `docs_helper_cli.py` | [Helpers](../helper-cli/index.md) |
| Native extensions | `NativeExtensionInterface.json`; CMake/codegen/hooks | `docs_native_extension.py` | [Native extensions](../native-extension/index.md) |
| Prototypes | `PrototypeFormatInterface.json`; prototype bakers/properties | `docs_prototype_format.py` | [Prototypes](../prototype-format/index.md) |
| Maps | `MapFormatInterface.json`; loader/baker/Mapper/runtime | `docs_map_format.py` | [Maps](../map-format/index.md) |
| Models | `ModelFormatInterface.json`; model parser/baker/runtime | `docs_model_format.py` | [Models](../model-format/index.md) |
| Text | `TextFormatInterface.json`; text bakers/packs/runtime | `docs_text_format.py` | [Text](../text-format/index.md) |
| Effects | `EffectFormatInterface.json`; effect baker/renderers | `docs_effect_format.py` | [Effects](../effect-format/index.md) |
| Images | `ImageFormatInterface.json`; image baker/sprite factories | `docs_image_format.py` | [Images](../image-format/index.md) |
| Particles | `ParticleFormatInterface.json`; backend registries/bakers/runtime | `docs_particle_format.py` | [Particles](../particle-format/index.md) |
| Fonts | `FontFormatInterface.json`; font loader/layout/rendering | `docs_font_format.py` | [Fonts](../font-format/index.md) |
| Audio | `AudioInterface.json`; audio baker/resource/audio managers | `docs_audio.py` | [Audio](../audio/index.md) |
| Video | `VideoInterface.json`; raw copy/video playback | `docs_video.py` | [Video](../video/index.md) |
| Packages | `PackageInterface.json`; `DefinePackage` and `package.py` | `docs_package.py` | [Packages](../packages/index.md) |
| AiControl | `AiControlProtocol.json`; reference client/sample | `docs_ai_control_protocol.py` | [AiControl](../ai-control-protocol/index.md) |

Paths in the owner/generator columns are under `BuildTools/` unless qualified otherwise. Each generator's `--write` regenerates its declared model/reference outputs; `--check` compares current outputs. Read its current parser/source before invoking it. Passing parity establishes that generator's properties, not runtime support on every backend/platform.

### Generated CMake project interface

The JSON documents declarations implemented by CMake; it does not declare executable options. Only source roles consumed by actual targets are supported. Arbitrary `AddEngineSources` metadata registration does not prove a role compiles.

### Generated BuildTools CLI reference

Help, choices, cardinality and defaults come from the executable parser. Project build commands use their documented project cwd; an Engine-root invocation is not universally valid.

### Generated helper CLI reference

The helper inventory is explicit and AST-checked against parser factories. It excludes commands owned by the main CLI/package models and does not imply that removed test/coverage helpers remain supported.

### Generated native-extension interface

Roles, hook signatures/fallbacks and binding rules are revision-pinned source contracts, not a cross-revision binary ABI. See [Native Extensions](../../how-to/native-extensions.md).

### Generated prototype-format reference

The grammar model derives built-in properties from the current native API model; project catalogs and semantic combinations remain project-owned.

### Generated map-format reference

The model separates authoring, side-specific baking and runtime ownership. Quantity/stacking is not a built-in `Item.Count` contract.

### Generated model-format reference

The model projects accepted parser tokens, composition and bounds/animation-adjacent metadata. Use the owning guide for ordering and visible acceptance.

### Generated text-format reference

The model covers raw syntax, language normalization and lookup; successful baking does not establish per-pack authored base-language coverage or project key parity.

### Generated effect-format reference

The model covers pass state, resources and backend artifacts; transient HLSL compilation is not a persisted HLSL payload.

### Generated image-format reference

The model separates accepted source formats, private baked bytes, runtime factories and failure/sprite caches.

### Generated particle-format reference

The model describes backend capabilities, cooked bounds and renderer restrictions. A backend-neutral facade does not make every backend feature interchangeable.

### Generated font-format reference

Descriptor parsing, font slots, metrics and draw semantics are Engine-owned; project glyph/localization and visible acceptance remain separate.

### Generated audio reference

Decoding, exact-path delivery and mixing primitives do not own a game's sound catalog, spatialization or audible qualification.

### Generated video reference

The Ogg/Theora primitive is not a complete cinematic, subtitle, container-audio or streaming system.

### Generated package interface

`CONFIG`, repeated `BINARY`, per-entry `POSTFIX` and `INCLUDE` must agree with the actual declaration parser. Packaging checks do not prove installer, signing, deployment or installed-runtime behavior.

### Generated AiControl protocol reference

The runnable `Examples/AiControlSample/run_protocol_smoke.py` exercises the project-neutral protocol sample; it is not a native game-client or gameplay qualification.

## Generated public example repository registry

`Examples/PublicRepositories.json` and `Examples/PublicRepositoryTemplate/` feed `docs_examples.py` and the [public-example registry](../public-examples/index.md). Pinned candidate validation requires the declared pin, committed Engine gitlink and checked-out revision to agree. Current-compatibility mode reports its temporary tested revision without replacing the release pin. Governance, provenance and publication authority remain explicit; prospective external CI policy is not proof this fork runs CI or published repositories.

## Documentation snippet inventory

`SnippetPolicy.json` and `docs_snippets.py` inventory canonical fenced blocks into the generated snippets report. Parser coverage is not semantic compilation or execution. `--external` additionally requires the installed Bash/PowerShell parsers and does not execute commands. Regenerate after fence changes, before localization/site/AI delivery; use [Snippet Validation](../../contributing/documentation/snippets.md).

## Documentation evidence and media artifacts

`ExternalProjectEvidence.json`, `DocumentationDiagrams.json` and `DocumentationScreenshots.json` own external revision provenance, deterministic diagram sources and screenshot capture inputs respectively. Their generators validate/update the corresponding reports. External projects never override Engine source. Regenerate diagrams through their owner and recapture screenshots when triggers fire; do not bless unexplained media with new hashes. Historical reports remain historical evidence.

## Generated support and localization status

`SupportMatrix.json`/`docs_support_matrix.py` distinguish source-capable, build and runtime evidence. `docs_localization.py` checks paired document identity, normalized EN source hash, ordered fence parity and locale-preserving links, then owns `docs-manifest.json#/translation_status`. Current complete enforcement requires every required mirror. A fresh hash is not a semantic translation review.

## AI documentation delivery

`docs_ai_delivery.py` projects the authored manifest into logical public `llms.txt`, `llms-full.txt` and `docs-manifest.json` routes. Local outputs live in ignored `Workspace/Documentation/`, as mapped by `documentation_metadata.py`; they are not repository-root authored files. `docs_prepare.py` also prepares site inputs there. `docs_site_build.py` renders into `Workspace/DocumentationSite/`. Public upstream URLs do not prove this fork deployed them.

`Docs/ai-evaluation.json` and `docs_ai_eval.py` own deterministic retrieval checks, not model-answer or runtime acceptance. Full bundles omit generated detail pages in favor of canonical models. Follow [ADR-0003](../../contributing/decisions/0003-manifest-backed-ai-documentation-delivery.md).

## Documentation site data

`docs_site.py` owns navigation/search and `docs-manifest.json#/routing`, preserving localization data; AI delivery preserves both while refreshing hashes. Generate snippets, localization, site/search/routes, relevant AI evaluation, then AI delivery last. Rendered-artifact and browser checks are separate, dependency-consuming acceptance under [Site Publication](../../contributing/documentation/site-publication.md), not automatic consequences of source validation. No installation or publication is implicit.

## Multi-domain diff and change disposition

`docs_contract_diff.py` compares all current canonical generated models against the same paths at an exact baseline. Native entries delegate to `docs_api_diff.py`. Breaking classification uses baseline stability; each required disposition is an exact domain-bound entry, and relabeling the current symbol `internal` does not bypass the gate. Model-source/scope/contract changes also require disposition. Keep exact domain/base/current digests in `Docs/contract-change-dispositions.json` and revision-pair reports in ignored workspace outputs. See [Contract Change Management](../../contributing/contract-change-management.md). Local range checks remain required even with workflows archived.

## Project remote-call supplement

Project `.fos`/`.cs` remote calls are baked by `MetadataBaker`, not added to `api.json` by another parser. `docs_metadata.py` decodes paired authoritative metadata, requires matching signatures and limits, and emits the project catalog. From an embedding project root:

```bash
python Engine/BuildTools/docs_metadata.py \
  --root . \
  --metadata Baking/Metadata/Metadata.fometa-server \
  --metadata Baking/Metadata/Metadata.fometa-client \
  --write
```

Use identical inputs with `--check` after baking. The catalog records input hashes, backend-correct handler syntax and `MaxBytes`/`MaxCollectionSize`, including explicit zero limits. Source hints do not preserve full repository paths/lines or a Managed declaring type/actual task return. Managed RPC supports supported scalars/arrays, not dictionaries merely because callback marshalling does. [Remote Calls](../scripting/remote-calls.md) owns the full authority and serialization contract.

## Metadata registration entry points

`MetadataRegistration.h` declares side/stub `Register*Metadata`, `RegisterDynamicMetadata`, `ReadMetadataBin` and `ReadMetadataVersion`. Templates supply generated registration/common code. Runtime dynamic metadata includes enums, entities/holders, value/ref/fixed types, properties, events, remote calls, settings and migrations.

## Engine hook tags

`EngineHook` names/signatures are closed by codegen and the [hook reference](../native-extension/hooks.md). Optional absent hooks receive generated fallbacks; project declarations suppress them. Configuration hooks return `void` and mutate the supplied `GlobalSettings&` during startup construction, not a boolean change signal or live gameplay settings. `ApplicationShutdownHook` is deliberately excluded from compatibility-hashed presence; other hook behavior follows its owning lifecycle contract.

## Script `Entity` promotion

The script `Entity` type maps to target-specific native entity classes. Proto/abstract casts cannot bypass target ownership: native marshalling reads base handles then checked-narrows to the target and throws on sibling-type mismatch. Arrays retain API-specific destroyed/null-element policy. Entity dictionary keys and dictionary-nested entity arrays lack supported conversion contracts and are rejected.

## Dynamic metadata

The native declaration parser accepts `Version`, `Property`, `Proto`, `Component`, `Remove` and `Enum` migration kinds, not `Entity`/`EntityHolder`. Property/Proto actions `Rename`/`Transform` have five tokens; `Remove` has four and no replacement. Property destinations must exist; transforms require a Persistent property and synchronous attributed callback. All callbacks see the unchanged original document; results stage before enqueue, and an exception leaves that document/update queue unchanged. This is not a database-wide transaction. Removed-name rules are permanent tombstones; old top-level database keys may remain. See [Managed migrations](../../how-to/scripting/managed-csharp.md#document-property-migrations) and [AngelScript migrations](../../how-to/scripting/style-and-refactoring.md#document-migrations).

Holder side filtering precedes type lookup; shared off-target holders keep Stub properties, while unknown active-side types fail baking. Enum name remaps apply during persisted-value resolution, including scalar values and dictionary keys, not as old callable APIs.

### Metadata version

**A server and its clients must run metadata produced by one bake.** Property indices depend on registration order. Native compatibility alone cannot enforce this: project metadata is registered from baked resources. `MetadataBaker` hashes the full parsed tag stream before side filtering, so one bake shares its metadata version across roles.

Each file begins with magic, a `uint16` file-layout version and length-prefixed metadata version. A reader/writer token change requires a file-version bump even when tag hashes do not change. Header helpers reject foreign/truncated/old-layout input before section decoding. Do not copy a file-version constant into manual prose as an inventory owner.

The invariant is enforced at matched server/client deployment, server updater startup comparison, updater post-sync re-read before `ClientEngine`, and the final gameplay handshake race check. `Properties::VerifyRestoredPropertyData` independently checks target enablement, virtual flags and plain-data size. `Network.ForceMetadataVersion` is only a diagnostic override, not a production compatibility mode. Diagnose directories and reported versions; never suppress the mismatch guard.

## Properties and generated contracts

`Properties.*` owns raw data, registrars, typed storage, callbacks and serialization. `hstring` has the shared eight-byte native/value ABI width, but persistence/wire serialization uses its resolved hash, not pointer padding. Registered fixed value layouts are packed, trivially copyable native data with aligned field offsets and no tail padding; identity-bearing, string/collection or unsupported nested data belongs in ref types.

Managed baking derives indexed `ManagedInteropAbi` slots/nullability/factories/adapters from the same metadata. Early binding rejects count/hash mismatches; generated API/ABI files participate in incremental stamps. Wrappers are backend-load-context-specific, bind Engine ownership explicitly and reject access after unbind; a late finalizer must not call released native state. See [Managed C#](../../how-to/scripting/managed-csharp.md).

## Public API relationship

Use the generated [Public Contract Index](../public-contract/index.md) for domain inventory and [native API model](../../../generated/api.json) for exact native records. Classifications follow source-owned scope/exact contracts, not copied counts or assumptions about defaults. A complete inventory is not a broad stability or binary-compatibility promise.

## Metadata and baker relationship

Codegen produces compiled C++/include inputs; `MetadataBaker` produces side-specific resource metadata; runtime registration consumes the latter. A correct source model does not prove the selected project's compile, bake or deployment used it.

## Verification and change routing

For changed annotations/signatures, regenerate the native model/reference and review diffs; configure/compile affected native roles and every selected script backend, bake both resource sides, check paired project metadata, then exercise the affected application path. For serialization changes, qualify isolated save/reload/restart and update source-owned migration/compatibility metadata. For model prose, repair the owner and reviewed RU overlay before regeneration. For documentation-only changes, run relevant existing generator checks and the standalone snippet/localization/corpus checks after fresh prerequisites. Report exact target, commands, outcomes and gaps; no removed suite, archived workflow or successful generator alone proves runtime correctness.
