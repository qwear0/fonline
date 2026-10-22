---
layout: default
title: Verification and tests
locale: en
document_id: testing
permalink: /Docs/en/contributing/testing/
---

# Verification and tests

This FOSquad engine fork follows the owner's explicit verification policy in [AGENTS.md](../../../../AGENTS.md), rather than the upstream test-suite workflow.

## Policy

- Do not write, extend or modify automated tests or test infrastructure without an explicit user request. This includes temporary scripts and delegated tests; do not routinely ask for exceptions.
- Use the least costly adequate existing check, compiler/type checker, or direct application CLI/API/UI interaction. Do not recreate a test suite under the label of diagnostics or smoke checks.
- Compare observed behavior with the user's requirements. Report actual checks, results and significant gaps.
- Missing new tests are not a defect and do not justify a test-coverage review request.
- GitHub workflow definitions are archived under `.github/disabled-workflows/`, outside the active workflows directory. Do not rely on CI. Remote settings were not changed; the archive takes effect on GitHub only after publication.

## Removed surfaces

The native `Source/Tests/` suites and `TestingApp.cpp`, managed CoreScripts/synchronization/analyzer test projects, BuildTools Python unit suites, debugger adapter tests and the native-extension sample's unit executable have been removed. The generated `UnitTests`, `RunUnitTests` and test-based coverage targets no longer exist. `FO_UNIT_TESTS` and `FO_CODE_COVERAGE` must remain `OFF`; enabling them fails configuration with an explicit diagnostic.

Catch2 is no longer added to the build. Vendored source under `ThirdParty/` and `BuildTools/msicreator/` is unchanged. Runtime diagnostics, the AI-control bridge, manual gameplay/example tooling and source/content validators remain available; removing unit suites must not disable production safeguards.

## Practical verification

For an engine change, configure and build the smallest affected embedding-project target. Compile affected script roles when metadata or bindings change; bake resources when content inputs change. Use direct client/server/mapper interaction when compilation alone cannot establish the requested behavior.

Use the embedding project's documented presets and targets, or the retained opt-in routes in [MinimalProject](../../../../Examples/MinimalProject/README.md) and [NativeExtensionSample](../../../../Examples/NativeExtensionSample/README.md). Exact game paths, presets, and policy are project-owned, not universal Engine prerequisites.

Dated reports and changelogs may describe removed tests as history. Active guides/models that still require those suites need repair at their owner; they are not automatically historical exemptions. Production documentation/content validators, rejected-option diagnostics, and compiler checks remain active safeguards. Preserve real failure exits and report pending generated or domain prerequisites. Game/engine commits remain separate; never invent a revision pin for uncommitted work.
