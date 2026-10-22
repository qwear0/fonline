---
title: Generated Support Matrix
document_id: generated-support-matrix-index
locale: en
generated: true
generated_by: BuildTools/docs_support_matrix.py
---

# Generated Support Matrix

This page checks live BuildTools targets and retains archived workflow definitions separately; this fork has no active CI gates.
Archived targets are historical configuration, not evidence that a build or process route ran on the current revision.

## Evidence levels

| Level | Meaning |
|---|---|
| `build_gated` | Reserved for an active required workflow that configures and compiles the profile on every change; no profile currently has this level in this fork. |
| `smoke_gated` | Reserved for an active build gate plus a named automated process route; archived workflow definitions are not executed evidence. |
| `source_capable` | The live BuildTools registry exposes a target. This fork has no active required CI gate; a target declaration proves neither a completed build nor runtime acceptance. |
| `not_in_public_matrix` | No supported validation target is published for this application/platform combination. |

## Platform profiles

| Host / target | Compiler | Level | Applications | Available local targets | Archived workflow targets | Runtime evidence | Limitations |
|---|---|---|---|---|---|---|---|
| Windows / Windows x64 | MSVC 19.44 or newer | `source_capable` | desktop client and headless client; server, headless server, and Windows service; mapper, animation viewer, and particle viewer; AngelScript compiler; resource baker | `win64-client`, `win64-server`, `win64-mapper`, `win64-ascompiler`, `win64-baker` | `win64-client`, `win64-server`, `win64-mapper`, `win64-ascompiler`, `win64-baker` | No process-level smoke route is required by the checked BuildTools validation registry. | Archived lane definitions are historical configuration, not current build or runtime evidence. Renderer, driver, database, packaging, deployment, and lifecycle acceptance remain project-owned. |
| Windows / Windows x86 | MSVC 19.44 or newer | `source_capable` | desktop client | `win32-client` | `win32-client` | No process-level smoke route is required. | Server and tool applications are outside the published x86 validation surface. |
| Ubuntu 24.04 / Linux x64 | Clang 20 or newer | `source_capable` | desktop client and headless client; server, headless server, and daemon; mapper, animation viewer, and particle viewer; AngelScript compiler; resource baker | `linux-client`, `linux-server`, `linux-mapper`, `linux-ascompiler`, `linux-baker` | `linux-client`, `linux-server`, `linux-mapper`, `linux-ascompiler`, `linux-baker` | No process-level smoke route is required by the checked BuildTools validation registry. | Ubuntu 24.04 is the archived lane host, not a fresh qualification. Other distributions, runtime, installers, signing, deployment, and rollback require project acceptance. |
| Ubuntu 24.04 / Linux x64 | GCC 13 or newer | `source_capable` | desktop client and headless client; server, headless server, and daemon; mapper, animation viewer, and particle viewer; AngelScript compiler; resource baker | `linux-gcc-client`, `linux-gcc-server`, `linux-gcc-mapper`, `linux-gcc-ascompiler`, `linux-gcc-baker` | `linux-gcc-client`, `linux-gcc-server`, `linux-gcc-mapper`, `linux-gcc-ascompiler`, `linux-gcc-baker` | No GCC-specific process smoke route is required. | Neither GCC nor Clang has a current required runtime lane in this fork. Qualify the compiler and artifact actually shipped. |
| macOS 26 Intel and Apple Silicon runners / macOS x64 and arm64 | AppleClang | `source_capable` | desktop client | `mac-client` | `mac-client` | No process-level client smoke route is required. | The public matrix does not qualify macOS server, mapper, tools, packaging, signing, or notarization. |
| macOS 26 Intel and Apple Silicon runners / iOS client | AppleClang | `source_capable` | client library/application bundle inputs | `ios-client` | `ios-client` | No simulator or device smoke route is required. | Provisioning, signing, App Store delivery, device input, audio, networking, and lifecycle acceptance are project-owned. |
| Ubuntu 24.04 cross-build host / Android armeabi-v7a and arm64-v8a | Android NDK Clang | `source_capable` | client shared library/package inputs | `android-arm32-client`, `android-arm64-client` | `android-arm32-client`, `android-arm64-client` | No emulator or physical-device smoke route is required. | APK assembly, signing, store delivery, device GPU/input/audio, pause/resume, and network acceptance are project-owned. |
| cross-build host / Android x86 | Android NDK Clang | `source_capable` | client shared library/package inputs | `android-x86-client` | - | No required CI or runtime lane exists. | Do not advertise Android x86 as a supported release target without a project-owned build and device/emulator gate. |
| Ubuntu 24.04 cross-build host / WebAssembly | Emscripten Clang | `source_capable` | browser client | `web-client` | `web-client` | No browser process smoke route is required by the checked BuildTools validation registry. | The stock Web target is WebGL 2 client-only. An archived cross-build definition does not qualify browser/GPU pairs, hosting, headers, persistence, audio activation, packaging, deployment, or rollback. |
| Windows / Windows x64 | ClangCL 20 or newer | `source_capable` | desktop client; server; AngelScript compiler; resource baker | `win64-clang-client`, `win64-clang-server`, `win64-clang-ascompiler`, `win64-clang-baker` | - | No required CI or runtime lane exists. | MSVC and ClangCL both require project-owned configure/build and runtime evidence; this fork currently qualifies neither through active CI. |

## Renderer qualification

| Platforms | Compiled backends | Qualification boundary |
|---|---|---|
| Windows, Linux, macOS | platform OpenGL plus opt-out Vulkan and SDL_GPU where the source backend can initialize | Build coverage is not renderer/runtime-driver coverage; every shipped backend needs a visible project scene. |
| Android and iOS | OpenGL ES plus platform capabilities; Vulkan and SDL_GPU remain compile-time optional outside Web | Device acceptance is required. |
| Web | WebGL 2 | Vulkan and SDL_GPU are excluded by the platform stage; browser acceptance is required. |
| headless applications | null/headless frontend | Do not infer visible rendering or audio support from a headless smoke. |

## Summary

- Platform profiles: **10**
- Build-gated profiles: **0**
- Smoke-gated profiles: **0**
- Distinct required CI validation targets: **0**

See [Support Matrix](support-matrix.md) for release interpretation and project acceptance requirements.
