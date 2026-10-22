---
layout: default
title: Documentation Maintenance
locale: en
document_id: documentation-maintenance
permalink: /Docs/en/contributing/documentation/
---

# Documentation Maintenance

Maintain reusable Engine contracts against this fork's current source. Start with [AGENTS.md](../../../../AGENTS.md), the [documentation skill](../../../../skills/fosquad-engine-doc-maintainer/SKILL.md), and the owning page in the [documentation index](../../index.md). Embedding projects own their game rules, content, launch profiles, services, and release policy.

## Source paths inspected

- `AGENTS.md`
- `Docs/documentation-manifest.json`
- `Docs/description-translations.ru.json`
- `BuildTools/documentation_metadata.py`
- `BuildTools/docs_prepare.py`
- `BuildTools/docs_validate.py`
- `BuildTools/docs_localization.py`
- `BuildTools/docs_contract_diff.py`
- `.github/disabled-workflows/validate.yml`

## Documentation ownership rules

The manifest classifies maintained pages by stable ID, audience, Diataxis kind, visibility, translation scope, owner, lifecycle state, target, and source paths. Add, move, retire, or retarget a page in the manifest and navigation in the same change. Current `sources` must exist; `historical_sources` records removed provenance, not runnable prerequisites. Preserve dated reports and vendored material as history rather than converting their old results into current evidence.

The manifest's owner review policy names primary owners, required evidence, and boundary co-review. Documentation, localization, runtime, scripting, content, frontend, networking, build/release, platform, tooling, and quality are separate responsibilities. External project evidence is discovery material, not a normative Engine dependency. A promoted contract needs Engine-owned implementation and current verification.

Canonical authoring is English; maintain the Russian mirror under the [translation workflow](translation.md). Links must stay inside the Engine checkout or use an explicit external source URL. Source code, configuration, and executable parsers win over inherited prose.

## Standard doc slice workflow

1. Record the real checkout, HEAD, dirty state, authorized paths, and affected contract owners. Preserve unrelated changes.
2. Read current implementation, public model inputs, consumers, and the owning EN/RU pages. A generated-reference parity pass alone cannot establish that a model describes supported behavior.
3. Repair the owner first: annotations/codegen for native API, `ProjectInterface.json` plus CMake implementation for build contracts, executable parsers for CLI, and the corresponding `*Interface.json` plus parser/baker/runtime for content, packaging, or native extensions.
4. Update the owning guide and Russian meaning together. Do not refresh a translation hash without reconciling its prose, fences, links, warnings, and limitations.
5. Regenerate affected models and references through their existing generators. Compile affected native/script roles, bake affected inputs, and use direct application interaction when compilation cannot prove the requested behavior. Follow [Verification and tests](../testing/): this fork has no own unit suites, and new tests or test infrastructure require an explicit request.
6. Compare every affected generated domain against the actual baseline using [Contract Change Management](../contract-change-management.md). The aggregate covers native API, CMake, main/helper CLI, packages, native extensions, prototype/map/model/text/effect/image/particle/font/audio/video, and AiControl. A native-only zero delta does not dispose other domains.
7. Update manifest membership/navigation and reviewed image provenance when their triggers fire. Use the generation order below, then run the relevant checks with their actual prerequisites.
8. Record exact commands, exits, changed paths, target identity, scope exclusions, and remaining blockers. Do not promote a page or corpus to verified from partial generation, stale reports, or archived CI.
9. Follow `AGENTS.md` for task-owned commits and normal fork pushes. A worker's narrower no-Git scope takes precedence for that worker. Version progression, bilingual change/migration notes, and exact publication-range checks belong to authorized integration under the [Engine update contract](../../how-to/release/versioning.md#every-master-update).

## Generated outputs and order

Public contract JSON, generated references, reviewed translations, and visual sources remain versioned. Never hand-edit generated references or catalogs. `docs_prepare.py` rebuilds ignored delivery data, not versioned contract models, Markdown, SVG, or PNG; it can fail after partial writes. A focused Markdown/skill edit does not require a full site rebuild, but a complete delivery validation does require fresh prerequisites.

1. Regenerate changed public models and EN/RU references; review generated-description translations and rebuild their status.
2. Regenerate source-owned diagrams and screenshot catalogs; recapture an image when its recorded trigger fires, rather than blessing unexplained bytes with a new hash.
3. Generate snippet coverage, then localization status.
4. Generate site navigation, locale search, and routes.
5. Generate AI evaluation when affected, then AI delivery last so public hashes describe the final inputs.

`docs-manifest.json` is shared generated metadata: localization owns `#/translation_status`, site generation owns `#/routing`, and AI delivery preserves those sections while refreshing document/artifact hashes. `BuildTools/documentation_metadata.py` maps local root endpoints and support files into ignored `Workspace/Documentation/`; rendered output belongs in `Workspace/DocumentationSite/`. Public URLs are logical delivery routes, not evidence that this fork deployed them. `AGENTS.md`, not generated `llms` bundles, is the checkout maintainer entry point.

## Link and path validation

From the Engine root, with generation authorized and prerequisites available:

```bash
python BuildTools/docs_prepare.py
python BuildTools/docs_snippets.py --check
python BuildTools/docs_localization.py --check --enforce-complete
python BuildTools/docs_validate.py
git diff --check
```

Use each affected generator's existing `--check` as well. `docs_validate.py` checks manifest ownership, current sources, links/anchors, publishing configuration, and generated freshness. It does not run removed Python/CMake/native suites. Missing or stale outputs remain failures; repair owners and regenerate rather than weaken checks. `docs_snippets.py --check --external` additionally needs installed Bash and PowerShell parsers and parses commands without executing them. Do not install dependencies implicitly.

Workflow definitions in `.github/disabled-workflows/` are retained historical source, not active CI. No remote settings change follows from a local archive. Rendered-site and browser acceptance are separate gates under [Site Publication](site-publication.md); local source checks do not prove deployment, screen-reader behavior, or runtime compatibility.

## Revision update reconciliation

Before any authorized pull/rebase/revision change, record old SHA and destination, preserve dirty work including untracked inputs in a named safety copy, and preserve baseline generated models when absent from Git. Rebase unpublished local commits onto the fetched base; never rewrite a published tip. Merge only diverged published histories. Engine and game are reconciled separately.

After integration, inspect the complete incoming range:

```bash
git log --oneline <old-engine-sha>..<new-engine-sha>
git diff --name-status <old-engine-sha>..<new-engine-sha>
git diff --stat <old-engine-sha>..<new-engine-sha>
```

Read every incoming implementation/configuration change and any retained relevant tests, not only commit subjects. Locate owners through manifest `sources`, reconcile all affected guides/models, regenerate in dependency order, and compare contracts against the preserved baseline. Run the smallest adequate build/bake/application path and documentation checks. Record old/new SHAs, compatibility/migration impact, generated deltas, and real failures before dropping a safety copy. A source update is not complete while required output is stale, a changed behavior has no owning disposition, or unresolved work exists only in a stash.

## Moving a public document

Preserve its stable ID, add the reviewed EN/RU pair, and retain the old Markdown path as a durable pointer. Keep exactly one canonical non-`replace` owner of a target. Update manifest/navigation and regenerate locale status, routes, search, snippets, and AI delivery. Verify old anchors, locale-preserving links, rendered routes, and language switching on the same completed site before removing transition state. A planned target alone never authorizes deleting the current route.

## Source-grounded writing conventions

Start with purpose and ownership; include decisive source paths and update triggers. Prefer relationships over copied inventories and unsupported counts. Keep engine capabilities separate from game policy. Describe remaining validation limits precisely; an active stale instruction is a repair, not automatically a historical exemption. Use the [snippet guide](snippets.md) for maintained fences and [translation guide](translation.md) for semantic freshness.

## Backlog status meanings

- `planned`: identified, not researched.
- `researching`: source inspection in progress.
- `drafted`: prose exists, semantic validation incomplete.
- `verified`: source review and the required post-edit checks completed successfully for the stated target.

## AI maintainer notes

`AGENTS.md` owns operational and Git policy; the skill supplies bounded retrieval, ownership, and evidence routing. Imported upstream publication/test mandates do not override the fork's current instructions. Report actual local installation status separately from publication; a loaded skill is not a corpus audit.

## Validation checklist

Confirm manifest/navigation ownership, faithful EN/RU updates, current source and generated prerequisites, complete contract dispositions, actual required check exits, whitespace, and preserved unrelated dirty state. State what was not checked. No live website, runtime, or full-corpus acceptance follows from a bounded documentation update.
