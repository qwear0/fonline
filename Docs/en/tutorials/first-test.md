---
layout: default
title: First Automated Test
locale: en
document_id: first-test-tutorial
permalink: /Docs/en/tutorials/first-test.html
---

# First Automated Test

Inspect and run the existing three-layer application checks in [Minimal Multiplayer](../../../Examples/MinimalMultiplayer/README.md). This route is retained runtime verification, not the removed Engine unit suites. New automated tests or infrastructure require an explicit user request under [Testing](../contributing/testing/); this lesson does not mandate adding them for every change.

## Test layers

`RunTutorialChecks` runs these layers in order:

1. **Baked metadata check.** `run_tutorial_smoke.py` decodes server and client
   metadata, requires symmetric remote-call declarations, and confirms that
   `SuppliesCollected` exists on both sides.
2. **Server content test.** The `TutorialContentTest` sub-config starts an
   isolated in-memory server with networking disabled. Script assertions create
   the location/map, add the NPC and item, and validate map invariants.
3. **Client-visible smoke.** A headless client connects to a real listening
   server, logs in, loads the map, collects the item, observes the synchronized
   count, and requests clean shutdown.

The headless client proves connection, baking, map load, localization, remote
calls, and replication. It does not prove pixels, input ergonomics, audio, or
GPU behavior; keep a visible pass for those claims.

## Run all layers

From a standalone example checkout:

```powershell
cmake --preset windows
cmake --build --preset windows-check
```

Use `linux` and `linux-check` on Linux. `python validate.py` selects these
commands for the current host.

From the Engine checkout, use the equivalent local route; the fork's workflows are archived, not active CI:

```powershell
cd Examples\MinimalMultiplayer
python validate.py
```

## Inspect one content invariant

Read `RunContentTest()` in [`Scripts/Tutorial.fos`](../../../Examples/MinimalMultiplayer/Scripts/Tutorial.fos). Follow an existing prototype/map assertion to its authored input, then its success marker and the runner's expected marker. Keep the complete existing body and clean shutdown intact. Use the existing bake/application route for a content change; do not add a replacement suite or temporary failure-injection script merely to satisfy an inherited documentation gate.

## Marker and timeout policy

Markers are a small public contract between the example scripts and runner:

- use stable, machine-searchable lowercase names;
- emit a marker only after the asserted state exists;
- require process exit code zero and every marker;
- bound every process wait;
- terminate both processes on failure;
- label captured server/client output and reject every missing marker.

Do not replace state assertions with log assertions. Script `verify(...)`
checks the world invariant; the marker tells the external runner which verified
milestone completed.

## Persistence scope

`SuppliesCollected` and `TutorialAccount` are declared `Persistent` in the script source. The current metadata probe checks field-name presence, not both persistence flags; its success message is not evidence that those declarations were verified. The tutorial uses
`Server.DbStorage = Memory`, so it does not claim persistence across server
process restarts. A game that claims restart durability must exercise its supported persistent backend, stop and restart the process, and inspect the restored entity state using an existing authorized application path.

## Recovery

- Metadata fails before startup: compare both baked sides and remote-call
  signatures; do not weaken the decoder.
- Client connects but never loads the map: inspect server world creation and
  player/critter switching before adding longer sleeps.
- A test is flaky: wait on semantic milestones with a bounded timeout; avoid
  fixed delays as success criteria.

For reusable fixture, marker, timeout, cleanup, and process-report semantics,
continue with [Gameplay and Integration Testing](../how-to/testing/gameplay-and-integration.md). For the fork's verification and removed-suite policy, use [Testing](../contributing/testing/).
