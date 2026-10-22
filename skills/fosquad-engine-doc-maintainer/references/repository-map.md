# Engine documentation and evidence map

All implementation paths here are relative to the target engine checkout. Verify actual files and wiring before documenting a behavior; this map is not a live API inventory.

## Reading order and owners

| Question | Documentation anchor | Source of facts |
| --- | --- | --- |
| How should an engine agent work? | `AGENTS.md` | Current owner rules and fork restrictions |
| Where are maintained guides? | `Docs/en/index.md`, `Docs/ru/index.md` | Current authored pages, manifest and navigation |
| What owns an engine capability? | `Docs/en/explanation/architecture/`, `Docs/en/contributing/source-tree/` | `Source/` and actual application/library wiring |
| How do projects embed/configure the engine? | `Docs/en/how-to/build/embedding-project.md`, `Docs/en/how-to/build/project-configuration.md` | `BuildTools/Init.cmake`, `BuildTools/cmake/`, project CMake inputs |
| How are metadata and bindings produced? | `Docs/en/explanation/scripting-runtime/`, `Docs/en/explanation/content-pipeline/` | `BuildTools/codegen.py`, annotations, native API and backend implementations |
| What is a public contract change? | `PUBLIC_API.md`, `Docs/en/contributing/contract-change-management.md` | Owning interface models, code and declared public contract dispositions |
| How are docs maintained and translated? | `Docs/en/contributing/documentation/index.md`, `Docs/en/contributing/documentation/translation.md` | `Docs/documentation-manifest.json`, translation metadata and the corresponding `BuildTools/docs_*.py` implementations |
| What checks are permitted in this fork? | `AGENTS.md`, `Docs/en/contributing/testing/index.md` | Actual remaining build/tooling surface, not deleted upstream suites |

## Implementation boundaries

- `Source/Applications/`: actual application entrypoints; verify enabled targets in `BuildTools/cmake/stages/Applications.cmake`.
- `Source/Client/`, `Source/Server/`, `Source/Common/`, `Source/Frontend/`, `Source/Essentials/`: native engine responsibilities; verify real relationships rather than inferring them from directory names alone.
- `Source/Scripting/`: backend bindings and scripting behavior. The engine supports more than the game's selected AngelScript backend.
- `Source/Tools/`: reusable bakers/editors/importers, not authored game content.
- `BuildTools/cmake/`, `BuildTools/buildtools.py`: build configuration and supported commands. JSON interface models and help output must agree with implementation.
- `BuildTools/codegen.py`: metadata/binding generation; source annotations and model inputs must be reconciled with any generated contract changes.
- `BuildTools/NativeExtensionInterface.json`, `BuildTools/cmake/ProjectInterface.json`: declared interfaces to check against the live fork; old declarations can outlive deleted consumers.
- `Examples/`: engine-owned embedding examples. Verify each example's current source; README claims may lag removal of its unit-test executable.
- `ThirdParty/` and vendored tool code: separate ownership. Do not edit or remove third-party tests as part of documentation cleanup.
- FOSquad `Scripts/`, `Gui/`, `SourceExt/`, `TLA.fomain`, `EngineRevision` and local launch presets: external game-owned inputs, not engine implementation.

## Authored versus derived documentation

- `Docs/en/`: canonical English guides; `Docs/ru/`: Russian mirrors according to manifest requirements.
- `Docs/documentation-manifest.json`: authored corpus classification, routing/publication/localization policy; inspect fields rather than trusting inherited claims about upstream deployment.
- `Docs/description-translations.ru.json` and `Docs/translation-glossary.json`: authored translation inputs for generated prose and terminology.
- Root compatibility entrypoints and `Docs/` forwarding pages: follow redirects to their owner; do not maintain a second copy of the same guide.
- `BuildTools/docs_*.py`: existing model generators, checks and site tooling with different effects. Not every command named `docs_*` is a read-only check.
- `Workspace/Documentation/`, `Workspace/DocumentationSite/`, generated indexes/catalogs and delivery files: outputs, not agent instructions. Verify `documentation_metadata.output_path` and the owning generator before assuming an output location.
- `Docs/DocumentationVerificationReport.md`, backlog, changelogs and migration notes: distinguish dated evidence and pending work from current acceptance.

## Known audit risk areas, not completed findings

- Test removal can leave stale manifest entries, validator expectations, interface roles, snippets and imported guides.
- Archived `.github/disabled-workflows/` files retain historical commands; no remote settings were changed merely by moving local files.
- EN edits may invalidate RU source hashes even when links still resolve.
- Existing generated models may reflect an earlier checkout or upstream distribution.
- A game `EngineRevision`, local engine HEAD and a dirty engine worktree describe different states.

## Skill ownership

Engine skill source: `skills/fosquad-engine-doc-maintainer/`. The game's separate skill is `skills/fosquad-doc-maintainer/` in its repository. Neither requires `/qsd` or the other skill's files for its own workflow.
