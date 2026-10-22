---
name: fosquad-engine-doc-maintainer
description: Maintain concise, source-grounded documentation for the independent FOSquad_Engine fork of FOnline. Use for engine orientation, documentation audits and impact checks, reusable native or scripting APIs, metadata and codegen, build and resource tooling, public contracts, EN/RU documentation, generated reference ownership, skills and agent instructions. Distinguish engine capabilities from embedding-game policy and historical upstream evidence.
metadata:
  version: "1.0.0"
  adapted-from: "qsd-doc-maintainer"
---

# FOSquad engine documentation maintainer

Keep reusable engine documentation accurate, navigable and separate from game-specific behavior. This skill owns the **independent engine checkout**, not the FOSquad game.

## 1. Establish scope

1. Read the active engine checkout's `AGENTS.md` and applicable nearer instructions.
2. Determine the target repository from the working directory and Git, not from this skill's globally installed location. If reached through a game's `Engine/` link, resolve the real engine root.
3. Inspect Git status and preserve prior changes. `AGENTS.md` grants standing authorization for task-owned commits and normal pushes to the configured fork, with its reconciliation/version rules. A worker's narrower no-Git scope still forbids Git mutation. A skill never authorizes changing a game's revision pin.
4. Start with `Docs/en/index.md`, the relevant engine guide and [references/repository-map.md](references/repository-map.md).
5. For documentation-system work, read `Docs/en/contributing/documentation/index.md` and relevant translation/generation guidance, but reconcile imported instructions with the fork's current policy and files.
6. Use [references/maintenance-policy.md](references/maintenance-policy.md) to classify impact and decide evidence requirements.
7. Before completion, follow [references/audit-checklist.md](references/audit-checklist.md). Its full-corpus route is not required merely to install or edit a skill.

## 2. Retrieve evidence selectively

- Use CodeGraph for unfamiliar native multi-file flows and impact discovery, normally starting with `maxFiles: 1..3` and the exact engine `projectPath`. Do not silently use a game-bound index for engine claims.
- Fresh verbatim source is already-read evidence for those lines. Edges, summaries and blast radii are navigation candidates, not completeness proofs.
- Use direct reads and targeted `rg` for Markdown, CMake, JSON manifests, exact literals, generated boundaries and unindexed languages/files.
- Verify decision-critical claims about lifecycle hooks, annotations, generated bindings, configuration, callbacks, persistence, network/ABI contracts and deletions against actual owners.
- Negative graph results never prove that a symbol, consumer, test or contract is absent. Fall back immediately on timeout, stale data or conflicting evidence; do not rebuild the index for documentation work.
- After a non-trivial code edit that used the graph, make one bounded missed-impact query. Skip it for documentation-only work or an unavailable provider.

## 3. Update the minimum correct documents

Classify the change as `no-doc`, `map-only`, `feature-doc`, `contract-flow`, `ownership-boundary` or `convention-or-agent-instructions` using the maintenance policy.

- Keep `AGENTS.md` operational, entrypoints navigational, and owning guides focused on stable engine behavior.
- Engine authoring is English. Maintain required Russian mirrors through the existing translation policy; do not mark stale text current by changing its hash alone.
- Classify new published guides through `Docs/documentation-manifest.json` and navigation. Agent-only skill support files are not automatically public site pages.
- Reconcile authored documentation, public contract inputs, generated reference ownership and delivery outputs. Do not hand-edit generated catalogs or copy graph dumps into maintained docs.
- Use reusable engine contracts as the default. Game profiles, gameplay rules, content and local native extensions remain owned by the embedding game.
- When game docs are authorized and affected, also read that checkout's `skills/fosquad-doc-maintainer/SKILL.md`. Neither repository's skill grants write permission to the other repository.
- Local game builds can provide engine compatibility evidence, but `/apps/FOSquad` and its private presets are not universal engine prerequisites.

## 4. Fork and verification discipline

- The root `AGENTS.md` testing policy overrides imported test mandates. Do not create or modify automated tests or their infrastructure, including temporary/delegated tests, without an explicit request. Missing new tests are not a defect.
- Own unit suites and their generated targets were removed; vendored tests and runtime diagnostics are separate. Never restore a suite, enable test/coverage flags or weaken a diagnostic merely to make an old documentation gate pass.
- Archived workflows are not active checks. Upstream website ownership, publishing settings and dated verification reports are not evidence of this fork's deployment.
- Use existing documentation tools and direct source inspection, not QSD's scanner/auditor or a newly invented validation framework.
- Read a check's help/source before running it. Distinguish a read-only `--check` from a generator, site build, dependency installation or publishing command.
- Repair authorized production validator/model drift at its owner without restoring tests or suppressing checks. Record out-of-scope dependencies and actual failures; a partial check never establishes a clean corpus.
- Preserve historical reports as historical. Correct active instructions at their owner rather than using a blanket disclaimer to exempt all stale documentation.
- Skill installation and focused documentation checks do not establish rendering, runtime compatibility, translation completeness or a full documentation audit.

## 5. Local distribution

The canonical source is `skills/fosquad-engine-doc-maintainer/` in the engine repository. Reference links are relative to this `SKILL.md`; implementation paths are relative to the **target engine checkout**, not necessarily the checkout containing the installed skill.

Local installation uses a symlink from `~/.agents/skills/fosquad-engine-doc-maintainer` to the canonical directory. Inspect any existing destination rather than overwriting it. This is a live local installation, not an immutable Git/npm release. Refresh Pi with `/reload` or start a new session; `/skill:fosquad-engine-doc-maintainer` explicitly loads it. Other agents can read the canonical file directly.

No scripts, new validation framework, dependencies, test suites or remote publication are bundled. Each repository's skill is independently usable.

## 6. Completion report

State:

- changed maps, owning guides, EN/RU mirrors, contract inputs, agent instructions and skill files;
- whether ownership or public contracts changed;
- evidence used and any semantic-index limitations;
- actual commands/results, generated-output changes and unresolved blockers;
- bounded-update versus full-audit scope and exclusions;
- local installation status, with no implication of remote publication or a changed game revision pin.
