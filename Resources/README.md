# FOnline Engine Resources

This directory owns reusable Engine resources, not a game's asset catalog.
`Core/` supplies default effects, fonts, and other shared content. `Embedded/`
supplies bootstrap resources used before normal project resources are ready.
Platform icons and resource-compiler inputs remain build inputs here.

Do not add arbitrary ZIP files to `Embedded/` and expect automatic delivery.
There is no repository-root `CMakeLists.txt` or supported `CreateResources`
procedure. An embedding project declares resource packs in its `.fomain`,
selects input directories, filters, bakers and runtime sides, then builds
`BakeResources` or `ForceBakeResources` from its configured project output.
Packaging selects those baked resources through the project package contract.

- [Project configuration](../Docs/en/how-to/build/project-configuration.md)
- [Baking pipeline](../Docs/en/explanation/content-pipeline/baking.md)
- [Packaging](../Docs/en/how-to/release/packaging.md)
- [Generated-content ownership](../Docs/en/how-to/build/generated-content.md)

Keep game-specific images, sounds, models, scripts, licensing, provenance and
acceptance evidence in the embedding project. A successful copy or bake does
not prove visual or audible correctness; inspect the affected client/tool path
on each claimed platform. Repair generated output at its authored owner.
