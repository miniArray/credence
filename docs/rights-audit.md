# Credence: scoped source-publication rights audit

## Decision and scope

The owner chose **Credence** despite a reported existing Reddit game with that name. The owner explicitly approved **all rights reserved** for the original work for now, credited to Simon W. Jackson. These are publication decisions, not trademark or legal clearance. Public source availability does not make this an open-source project.

The reviewed baseline is `29fc68153ad543ae8f658d0d4e9d13e19bbb5ebc`: 183 tracked files and 15 commits. `git shortlog -sne` identifies one Git author, Simon W. Jackson <simon@simonwjackson.io>, for all 15 commits. Git authorship is evidence of recorded attribution, not independent proof of every underlying right. There was no original-code license file at that baseline. This change adds `LICENSE.txt` and `THIRD_PARTY_NOTICES.md`; it does not change the third-party grants.

This audit covers that source tree, recorded provenance, the optional helper's identified source, and the notices added for source publication. It does not cover the entire local BW2 research repository, unpublished materials, all transitive toolchain/runtime dependencies, or the rights of similarly named games. It is not a legal opinion or a claim of independent creation without influences.

## Evidence checked

| Area | Evidence and result | Limit |
|---|---|---|
| Character models, textures, outfits, animations | Read `assets/characters/provenance.json` and all three archive `*-LICENSE.txt` files. Each grant explicitly says CC0 1.0 Universal. All 29 entries in `assets/characters/SHA256SUMS` verify. Provenance records three archive hashes, primary pages, upload IDs, selections, and modifications. | This check verifies the recorded curated payload, not a fresh download of all 439 MB of source archives or an independent chain-of-title investigation. |
| Fonts | Read both `assets/fonts/*OFL.txt` files, including authorship and Lato's Reserved Font Name. Alegreya SHA-256: `1065bc1fcfd1da0c1a18ddec81537dfdf06749db1ca3ae4d6dc40244058a6036`; Lato: `6f6940be0835c3ddec9199e5fc42be4cbc61ebcfd58c623fdf719366253f1780`. Font files and grants are unchanged. | No new font rights are claimed. Preserve each font's copyright and OFL text with redistribution. |
| Audio | Imported `tools/prepare-assets.py` and regenerated its four named WAVs in a temporary directory, without changing tracked assets. Every output matched the checked-in bytes. Hashes are below. | Reproduction establishes how these bytes are generated. It does not establish rights in all possible musical similarities. |
| Original game/source material | Baseline inventory contains Godot scripts/scenes/shaders, authored geometry and simulation, docs, Python/Nix tooling, and the identified assets. The supplied independent reviewer reported no commercial Black & White 2 code/assets in this tree. The game is not a loader for that game. | This is a scoped source review and reviewer finding, not proof that no protected expression could be disputed. No commercial game data is authorized for inclusion. |
| Optional input helper | Read this tree's `tools/headless-seat.{c,py}` and the identified original `scripts/headless-seat.py` at local repository `/home/simonwjackson/code/sandbox/decompile/bw2`, commit `d900362b8dd75d70bcab9c4184d9f7400f175470`. Git history for both original helper files at that commit records Simon W. Jackson as author. The source comments identify the retained, unused BW2 name-field operation. | This is Simon's copied generic tooling, not a license grant for unrelated material in the research repository. This game's copy adds private-display restrictions and scrolling. |
| Downloaded Wayland protocols | Downloaded the two URLs in `tools/headless-seat.py`; both SHA-256 hashes matched its pins. Read each XML copyright block and retained its full text under `licenses/`. | Schemas and generated helper files remain upstream-licensed. Generated code and linked-library redistribution need their own complete notices if ever shipped. |
| Godot | Read the primary [Godot 4.6 compliance guidance](https://raw.githubusercontent.com/godotengine/godot-docs/4.6/about/complying_with_licenses.rst). Copied verbatim `4.6.1-stable` `LICENSE.txt` and `COPYRIGHT.txt` to `licenses/GODOT_LICENSE.txt` and `licenses/GODOT_COPYRIGHT.txt`. SHA-256: `b0435e3b3e4e55238f05f4b306f30524a1b2e20147810d436eaa554fa6855c80` and `dc043a7dbf69632560219e72fbc61ef9fa7338c7a773660acd81b51590b69104`. | Godot is external to the source snapshot. Its copyright inventory is not a complete Nix closure or Android template audit. |

### Regenerated WAV SHA-256

| File under `assets/audio/` | SHA-256 |
|---|---|
| `ambience.wav` | `7cd2a08060840dbb2256a0491034b6b09b927a3ee698bf94d03ae0297f4311d1` |
| `rain.wav` | `0abc711dd3ad4f90246f11f20a8c401bcc405102f47840b72c934a1579328566` |
| `food.wav` | `c45a88715dc74223e6192941ddada1744765428898321d880d7661ff48b361f5` |
| `touch.wav` | `ce97c9933dd65b874bb300c487795e124126cb9b5dc3328a25119b60907ee3be` |

## Source-export boundary

Publish a clean tracked-tree snapshot, not a recursive copy of the working directory or a bundle of the old Git history. Include source, tests, docs, notices, provenance, and required runtime assets. The `.bin` glTF buffers, fonts, textures, and WAVs are source-project resources, not compiled game releases.

Exclude `.git/`, `.worktree/`, `.godot/`, `build/`, `artifacts/`, `result`, `result-*`, `__pycache__/`, and `*.pyc`. The existing `.gitignore` covers the generated working-tree paths; a tracked-tree export excludes them without relying on that ignore file as a security scanner. Never include keystores, signing passwords, ADB credentials, source archive downloads, captures, PCKs, APKs, launch bundles, native helper executables, or Nix runtime closures. The old ignored `build/` and `artifacts/` outputs are stale and are not publication candidates. No binary release is authorized by this publication.

The parent publication workflow must create the clean repository snapshot, commit/tag it, resolve the full source SHA, and verify that exact SHA before its dry run and publication. Renaming and rebuilding in this development checkout does not verify the new snapshot's source identity.

## Rename and distribution limits

Active product titles, package attributes, launchers, generated output names, environment names, and new user-data paths use Credence. The Android identifier becomes `org.credence.prototype`; it is not an update to `org.signsofrain.prototype`. There are no compatibility paths, dual reads, or migration. Existing saves, signing identities, and the old installed game stay where they were. No installed target or external Korri plugin was changed.

Historical reports, the initial brief, actual old capture paths, and asset-curation source paths retain the old name where changing it would falsify evidence or break the recorded asset hash. Existing small reports under `verification/` are historical evidence, not a claim that Credence has been tested on aka or a phone. New verification results must identify their own source SHA.

Both Linux packaging paths now accompany the game with readable original-work, asset, Godot, and protocol notices. The Nix package exposes them under `share/credence/`; the local build places them beside its pack. No unrequested licenses UI is added. The old PCK/APK notices and installed engine runtime are not repaired by a source change. Before any future binary publication, verify notice accessibility and all actual runtime/template dependency terms, especially on Android.

No source snapshot should claim that the whole project has no copyright, that naming is cleared, or that this audit settles infringement questions. The original-work reservation limits reuse; it does not remove third-party license obligations or resolve naming risk.
