# Engine documentation maintenance policy

Adapted from QSD's compact maps, change classes and evidence ladder. QSD's containers, directory templates and audit scripts are not engine requirements.

## Minimum correct scope

| Class | Trigger | Update |
| --- | --- | --- |
| `no-doc` | Internal change without altered behavior, public contract, layout or workflow | No documentation edit; explain the decision |
| `map-only` | Source/doc/entrypoint movement without changed semantics | Owning maps, navigation, manifest entries and inbound references |
| `feature-doc` | Engine behavior changes within an existing owner | Owning EN guide and required RU mirror |
| `contract-flow` | API, metadata, generated binding, configuration or resource contract changes | Producers/consumers, public contract inputs, migration guidance and affected generated references |
| `ownership-boundary` | Capability moves between subsystems or engine/game | Both owners' guides, responsibility statements and contract direction; separate repository scope |
| `convention-or-agent-instructions` | Workflow, skill routing or maintainer policy changes | `AGENTS.md`, skill guidance and owning operational docs; keep adapters thin |

A behavior change documented elsewhere is not `no-doc` just because the patch is small. Select the smallest sufficient scope, not a blanket regeneration of everything.

## Evidence and retrieval

1. Source, configuration and generator inputs establish current implementation contracts.
2. Existing generator/check output establishes only that tool's verified properties and revision.
3. Build and application observations establish only the exercised target/configuration.
4. Positive semantic relationships help locate evidence; summaries, missing edges and blast radius are not completeness proofs.
5. Imported prose, plans, old reports and upstream website metadata require reconciliation with this fork.

For dynamic or generated relationships, check the narrow decisive chain: annotation -> generator -> binding, model -> consumer, CMake option -> target, command -> parser/dispatcher, serialized field -> reader/migration. Inspect declared versus implemented contracts; neither alone proves the other is current.

Use targeted direct reads for Markdown/JSON/CMake and a bounded graph query for unknown code flow. Verify deletion and exhaustive claims outside the graph. Do not paste graph inventories into curated documentation.

## Document layers

- `AGENTS.md`: operational authority; skills provide task-specific detail without duplicating the whole guide.
- Indexes/maps: stable reading order, owners, paths and update triggers.
- Owning guides: reusable contracts and durable flows, not an implementation transcript.
- Public models: source-owned machine contracts, with the documented change-management process when altered.
- EN/RU pages: canonical content plus semantic translation, with accurate freshness metadata.
- Backlog/history/changelog: explicit planned state, migration history or dated evidence.
- Generated reference/site delivery: reproducible outputs through existing owners; no hand-edited stand-ins.

Use one claim per bullet, repo-relative paths, explicit engine/game ownership, and labels such as `owner:`, `entrypoint:`, `code:`, `contract:`, `verification:`, `doc:` and `update-when:`. Do not require new test anchors for retired suites.

For a new focused guide, prefer: purpose/owner; source anchors; main flow; public/serialized contracts; failure clues and existing verification; related docs and update triggers. Aim roughly at 40-180 lines for a narrow page and 80-220 for a map, without removing essential caveats. Preserve existing frontmatter/document IDs/permalinks when compatible; do not impose QSD's numbered-section schema.

## Translation and generated ownership

- Follow `Docs/en/contributing/documentation/translation.md` for required mirrors and normalized source hashing. A changed hash certifies nothing without an updated, reviewed translation.
- Check authored description translations when generator model prose changes. Do not blindly regenerate over reviewed content.
- Read the owning `docs_*.py` help/source to distinguish `--check`, default writes and explicit generation.
- `docs_prepare.py` writes multiple ignored delivery outputs and runs dependent validation. It is not a harmless read-only prerequisite for every small Markdown edit.
- If an existing tool fails because a retired suite/path or stale policy is embedded in its contract, identify the owning drift. Do not re-create the suite, delete findings indiscriminately or invent a success report.
- Keep agent-only skill references outside the public-site corpus unless deliberately adopting them into its manifest/localization/navigation model.

## Scope and authority

A documentation skill does not authorize Git publication, version bumps, deployment, dependency installation, new tests or cross-repository edits. Read the current instructions and the user's actual scope. Full-corpus verification and rendered-site verification are separate from a local skill update.
