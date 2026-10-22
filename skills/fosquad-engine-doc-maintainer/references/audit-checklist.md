# Engine documentation checks and audit procedure

Do not call a bounded update a full audit. Installing or loading this skill does not verify the documentation corpus. Use the existing tools with their real prerequisites; do not copy QSD's auditor or create a new test/verification framework.

## Bounded update checklist

- Read applicable instructions and owning guides; verify changed claims against source/model/configuration evidence.
- Check local links relative to their documents, source paths relative to the stated repository, inbound references to moved pages and any required manifest/navigation changes.
- Preserve frontmatter, document identity and compatibility redirects where applicable.
- Assess EN/RU and generated-description impact. Do not update a translation hash without reconciling the translation itself.
- Keep agent-only skill references distinct from public site pages; do not enroll them implicitly in the site corpus.
- Inspect scoped diffs, untracked additions and whitespace using existing tools:

```sh
git status --short
git diff -- AGENTS.md README.md README.ru.md Docs skills
git diff --check
```

Read new untracked files explicitly: Git diff alone omits them. Attribute pre-existing failures rather than reverting unrelated changes or hiding errors.

## Existing documentation tool routes

Run commands from the engine root with the Python interpreter supported by the checkout. First inspect help/source if the command or its effects are unfamiliar.

| Purpose | Existing entrypoint | Limits and effects |
| --- | --- | --- |
| Full authored-corpus validation | `python3 BuildTools/docs_validate.py` | Read-only validator; relies on manifest and generated-output state, and can expose stale upstream test expectations |
| Translation parity/freshness | `python3 BuildTools/docs_localization.py --check --enforce-complete` | Checks required mirrors and generated translation status; stale/missing outputs are not a successful translation audit |
| Build/config reference parity | `python3 BuildTools/docs_cmake.py --check` | Check the owning model and current implementation; not game configuration validation |
| Native-extension reference parity | `python3 BuildTools/docs_native_extension.py --check` | Does not establish runtime ABI compatibility by itself |
| Prepare delivery outputs | `python3 BuildTools/docs_prepare.py` | Writes generated catalogs/indexes under the configured output locations and invokes dependent checks; inspect prerequisites and report partial failure |
| Render documentation site | `python3 BuildTools/docs_site_build.py` | Separate output/dependency-consuming build; not needed for a skill-only change |

Other `BuildTools/docs_*.py` tools are selected by the affected owner, not executed blindly as a shell glob. The table is a routing aid, not a claim that these tools currently pass. Do not add a nonexistent `--check` flag to `docs_validate.py` or `docs_prepare.py`. Inspect actual options before selecting a scope.

## Full audit, when requested

### 1. Inventory and baseline

Record real engine root/HEAD, dirty state and the authorized corpus. Keep any game audit separate. Inventory:

- root guides, agent files and skill/support documentation;
- canonical EN pages and required RU counterparts;
- public models, manifests, description translations, navigation and redirect pages;
- source/build-tool/example READMEs and operational guidance;
- dated reports, backlog, migration history and archived workflows;
- generated/ignored outputs and their owners, separately from authored inputs;
- vendored material and external websites as explicit exclusions or separate verification scopes.

Use manifest declarations and actual tracked/untracked files together: a manifest can omit existing documents or still list deleted ones. Account for every in-scope document before claiming complete coverage.

### 2. Source-grounded consistency pass

For each area, verify path/link/anchor correctness, source ownership, API signatures, metadata/settings, target/CLI availability, public-contract direction, generated owners, prerequisites and verification claims. Cross-check EN/RU meaning and current freshness metadata.

Pay particular attention to:

- removed unit-suite paths in active guides, manifests, snippets and validators;
- declared TESTS roles, test/coverage options or runner commands without current consumers;
- archived versus active workflows, local build evidence versus CI claims;
- old submodule assumptions and embedding-project-specific paths in reusable procedures;
- upstream domain/repository/publication assertions presented as this fork's live state;
- old generated inventories, translation hashes and closed backlog claims without fresh evidence.

A history page can describe deleted code; an active procedure cannot require it without explanation and a supported alternative. Do not delete historical evidence or create placeholder files to make path checks green.

### 3. Existing checks and generation

Run proportionate existing read-only checks, preserving nonzero results. For the full delivery route, inspect prerequisites, run the existing `docs_prepare.py` when generation is in scope, then the relevant checks and `docs_validate.py`. It may fail before producing all outputs: report what completed, do not continue as though preparation passed.

If source policy/model/validator corrections are needed, keep them owned and justified by the actual fork contract. Do not restore retired tests or strip all checks merely for a green result. New/modified tests or test infrastructure still require an explicit request; production documentation validation is not a reason to recreate suites.

Rendered layout, navigation/search behavior and live publication are separate checks. Only run the existing site/browser routes when authorized and dependencies are available. Never install dependencies, upload artifacts, publish, or change remote GitHub settings implicitly. Record excluded or blocked checks explicitly.

### 4. Findings and completion

Each actionable finding should name its document path/line, contradictory source/model evidence, impact, owner and proposed correction. Distinguish wrong public/runtime contracts from cosmetic navigation issues and stale historical metadata.

Report corpus scope, actual commands and results, generated outputs touched, EN/RU state, unresolved findings and material gaps. Do not equate successful generation, link checking, a prior report or a few sampled pages with complete semantic correctness. Report game and engine outcomes separately. Follow `AGENTS.md` for standing task-owned commit/push authorization and version reconciliation; a narrower worker scope can forbid all Git mutation. An audit alone never authorizes a game revision-pin change.
