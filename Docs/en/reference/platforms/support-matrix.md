---
layout: default
title: Support Matrix
locale: en
document_id: support-matrix
permalink: /Docs/en/reference/platforms/support-matrix.html
---

# Support Matrix

This page defines what the rolling `current` FOnline documentation may call supported. It separates source capability, required CI compilation, automated process smoke tests, and project release acceptance.

Use the generated [exact matrix](generated-matrix.md) for the current platform profiles and validation target names. The machine-readable model is [support-matrix.json](../../../generated/support-matrix.json).

## Support decision

Use only these evidence labels: **Build-gated** means required CI configures and
compiles it; **Smoke-gated** adds an automated process route;
**Source-capable** means the source exposes it without required CI proof; and
**Project-qualified** means an embedding game repeatedly accepts its actual
artifact. A project release matrix must keep Renderer, Networking, Packaging,
and Updater evidence explicit. A build or Engine smoke does not silently fill
those project-owned cells. Before a release claim, bind those cells to the same
versioned artifact and include its install/start/runtime result; an implemented
payload branch is capability, not "full support."

## Source paths inspected

- `BuildTools/SupportMatrix.json`
- `BuildTools/docs_support_matrix.py`
- `BuildTools/buildtools.py`
- `BuildTools/cmake/stages/Init.cmake`
- `BuildTools/cmake/stages/Applications.cmake`
- `.github/disabled-workflows/validate.yml` (historical definition, not active CI)
- `Examples/MinimalProject/`
- `Examples/MinimalMultiplayer/`
- `Docs/generated/support-matrix.json`
- `Docs/en/reference/platforms/generated-matrix.md`

## Support vocabulary

- **Build-gated** means the required workflow configures and compiles that profile on every change.
- **Smoke-gated** means the profile is build-gated and a named starter or multiplayer process route also runs.
- **Source-capable** means BuildTools exposes the profile, but required CI does not exercise it.
- **Project-qualified** means an embedding project has added the runtime, packaging, hardware, service, or store checks needed for its release. Engine CI cannot make this claim for a game.
- **Unsupported for release** means a project has neither an Engine build gate nor its own maintained acceptance route.

These labels are deliberately narrower than "works on my machine." A successful cross-compile does not prove a window opens, a device resumes correctly, a browser connects, a renderer works on shipping drivers, or a signed package can be installed.

## Current fork baseline

GitHub Actions are disabled in this workspace. The workflow under
`.github/disabled-workflows/` is an archive, not an active gate or proof of a
successful build on the current revision. All profiles in the current matrix
are **source-capable**. Archived target lists preserve historical configuration
separately from available local BuildTools targets; neither list is a run result.
Moving the local workflow did not change remote repository settings.

Engine-owned examples retain opt-in local validators for a minimal headless
project, tutorial multiplayer flow, native extensions, packaging, and Content
Showcase. Run only the relevant existing route and report its exact revision,
configuration, result, and limits. Unit suites are retired; do not enable the
removed test/coverage options.

Visible rendering, audio, signing/installers, persistence backends, public
networking, and long-running service operation remain project-owned acceptance
concerns. A dated upstream or external-project result cannot qualify this fork.

## Application boundaries

Desktop builds may expose more applications than mobile and Web builds. The public mobile/Web matrix covers the client path only. Do not infer supported servers, mappers, bakers, compilers, services, or daemons on those targets merely because common source can compile there.

Application construction lives in `BuildTools/cmake/stages/Applications.cmake`;
local validation names live in `BuildTools/buildtools.py`. The archived workflow
records former selections only; there are no current required CI targets.

The generic Editor target has been removed. Interactive map authoring is provided by Mapper; animation and particle inspection use their focused viewers. Required CI must not retain `*-editor` validation names after the corresponding BuildTools target disappears.

## Renderer boundaries

Backend availability is a compile-time capability, not visual qualification:

- Windows, Linux, and macOS compile their platform OpenGL path and can include Vulkan and SDL_GPU unless disabled.
- Android and iOS compile mobile platform capabilities; device acceptance remains mandatory.
- Web uses WebGL 2. The platform stage excludes Vulkan and SDL_GPU.
- Headless smoke tests deliberately prove no pixels and no audible output.

Every game that ships a renderer must maintain a representative visible scene on each supported GPU/platform family. Capture startup, map load, resize/orientation where applicable, device loss or background/resume where applicable, and at least one effect, font, image, model or sprite, and GUI path used by the product.

## Project release matrix

An embedding project should copy the evidence model, not this table. For every shipping combination record:

| Dimension | Required project evidence |
|---|---|
| Host and compiler | Clean configure/build on the pinned Engine revision |
| Client platform and architecture | Install or launch on representative hardware/runtime |
| Server platform | Process/service lifecycle, database, backup, restore, logs, and graceful shutdown |
| Renderer | Visible scene and driver/device coverage |
| Networking | Native or WebSocket transport, reconnect, timeout, and compatibility behavior |
| Packaging | Reproducible package, contents audit, signing/notarization/store route |
| Localization | Bake, glyph coverage, layout, input, and language switching |
| Updater | Exact protocol/ABI compatibility and rollback/reinstall policy |

A project may promote a profile only after those gates are versioned and repeatable. A temporary manual pass is useful evidence, but it is not the same as maintained support. Use [Packaging and Release](../../how-to/release/packaging.md) to turn the packaging row into an auditable project procedure and acceptance lane.

## Adding or changing a profile

1. Add or modify the real validation target in `BuildTools/buildtools.py`.
2. Do not reactivate CI as a documentation repair. A future build gate needs an
   explicitly authorized active workflow and observed execution.
3. Update `BuildTools/SupportMatrix.json` with the narrowest truthful level.
4. Run:

   ```bash
   python BuildTools/docs_support_matrix.py --write
   python BuildTools/docs_support_matrix.py --check
   ```

5. Update platform how-tos and the embedding project's release matrix when behavior or prerequisites changed.
6. Do not promote `source_capable` to `build_gated` without required CI, or `build_gated` to `smoke_gated` without an executable route.

## Maintenance

The generated model checks local target names against the live registry,
historical selections against the archive, and rejects active-gate claims from
an archived workflow. It cannot infer runtime quality from compilation, so runtime evidence and limitations remain reviewed policy text.

When Engine or an embedding project is updated, audit the complete incoming range for changes to platform detection, minimum toolchains, application construction, BuildTools validation profiles, workflow runners, renderer gates, package support, and updater boundaries. Update this matrix in the same change.
