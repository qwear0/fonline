---
layout: default
title: GUI Integration Boundary
locale: en
document_id: gui-runtime-guide
permalink: /Docs/en/how-to/runtime/gui.html
---

# GUI Integration Boundary

> Engine-owned documentation. The reusable Engine owns rendering, input, window, resource, and script-export primitives. A high-level GUI object model, screen stack, layout library, generated screens, and authored GUI formats belong to the embedding project.

## Current status

The former Engine-owned AngelScript `CoreScripts/Gui.fos` and `Input.fos` library was removed when high-level script libraries moved to the embedding project during the Managed C# integration. The old generated GUI runtime reference was retired with it because its source contract no longer exists in Engine.

This is an ownership route, not a compatibility specification for that removed library. Do not restore the deleted `.fos` files merely to keep an Engine documentation generator alive, and do not infer a Managed C# GUI API from the old AngelScript types.

## What Engine provides

- application/window services and native input events;
- renderer, sprites, atlases, render targets, fonts, text, effects, video, and drawing exports;
- a native immediate-mode ImGui script facade for tools and project UI;
- backend-neutral metadata and generated script bindings for native APIs;
- client lifecycle hooks on which a project GUI can subscribe;
- AngelScript and Managed C# backends through which a project implements its GUI library.

Use [Frontend and Rendering](../../explanation/rendering/) for the native presentation contract, [Scripting](../../explanation/scripting-runtime/) for backend-neutral bindings, and [Managed C# Scripting](../scripting/managed-csharp.md) for C# authoring and runtime behavior.

## Native ImGui facade

`Game.ImGui` exposes Engine-owned immediate-mode windows, widgets, and layout
operations. `Game.IsImGuiAvailable()` reports whether a context and active frame
exist; acquiring `Game.ImGui` outside that frame throws. Keep facade calls in
the owning application's ImGui frame callback, not an arbitrary tick or worker.
Pair `Begin` with `End` even when `Begin` returns false. Client bindings also
provide sprite `Image` and `ImageButton` operations with size/UV validation.

This facade does not restore the removed retained-mode script library. Project
screen stacks, persistent widget state, declarative layouts, and GUI generators
remain project-owned. Native rendering and input remain Engine responsibilities.

## What the project must document

The embedding project owns and documents its GUI types, screen registration, stack/modal rules, layout and scaling, drawing order, mouse/keyboard/touch behavior, focus, drag/drop, item views, declarative formats or generators, localization behavior, and screen-specific acceptance tests. These contracts may differ between projects and scripting languages.

## Validation boundary

For an Engine-native render/input export change, regenerate the script API and build the affected native role. Then compile/bake every affected scripting backend in a representative embedding project and perform visible interaction checks on every claimed platform. Headless success is not visual acceptance.

For a project GUI-library change, keep its source-derived reference, tests, generated screens, and visual evidence in that project. Engine-only validation cannot prove project screen behavior.

## Maintenance triggers

Update this route when Engine adds or removes native presentation/input primitives, changes which scripting backends expose them, or introduces a new reusable Engine-owned GUI layer. A future Engine GUI layer needs an actual source owner, proportionate verification, generated/reference contract where useful, EN/RU documentation, project integration evidence, and visible acceptance before this page may call it implemented.

## Source paths inspected

- `Source/Frontend/`
- `Source/Client/`
- `Source/Scripting/CommonImGuiScriptMethods.cpp`
- `Source/Scripting/ClientImGuiScriptMethods.cpp`
- `Source/Scripting/*ScriptMethods.cpp`
- `Source/Scripting/AngelScript/`
- `Source/Scripting/Managed/`
- `Docs/en/explanation/rendering/`
- `Docs/en/explanation/scripting-runtime/index.md`
