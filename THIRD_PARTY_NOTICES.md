# Third-party notices

Credence's original-work notice in [LICENSE.txt](LICENSE.txt) does not change the terms below.

## Included assets

| Material | Author / copyright | Terms and source evidence |
|---|---|---|
| Curated character models, textures, outfits, and animations in `assets/characters/` | Quaternius | CC0 1.0 Universal. The verbatim grants are [base](assets/characters/base-LICENSE.txt), [outfits](assets/characters/outfits-LICENSE.txt), and [animation](assets/characters/anim-LICENSE.txt). [Provenance](assets/characters/provenance.json) records archive URLs, hashes, selected content, and modifications. `SHA256SUMS` records curated file hashes. |
| `assets/fonts/Alegreya-Regular.ttf` | Copyright 2011 The Alegreya Project Authors | [SIL Open Font License 1.1](assets/fonts/Alegreya-OFL.txt). |
| `assets/fonts/Lato-Regular.ttf` | Copyright (c) 2010–2015 Łukasz Dziedzic; Reserved Font Name Lato | [SIL Open Font License 1.1](assets/fonts/Lato-OFL.txt). |

The underlying Quaternius material retains its upstream CC0 dedication in the curated assets. This notice makes no new license grant for original contributions. The included font files and their notices are unchanged.

## Godot Engine and runtime dependencies

The game uses Godot Engine 4.6.1, which is obtained through the pinned Nix toolchain, not included as an executable in this source publication. Godot is MIT-licensed, copyright Godot Engine contributors and Juan Linietsky / Ariel Manzur. Its verbatim [license](licenses/GODOT_LICENSE.txt) and [third-party copyright and license inventory](licenses/GODOT_COPYRIGHT.txt) come from the `4.6.1-stable` source tag:

- <https://github.com/godotengine/godot/blob/4.6.1-stable/LICENSE.txt>
- <https://github.com/godotengine/godot/blob/4.6.1-stable/COPYRIGHT.txt>
- <https://godotengine.org/license>

Godot's bundled components retain their separate terms in that inventory. Nix dependencies, Android SDK/JDK tools, and export templates retain their upstream terms; they are not relicensed here. The inventory is not an audit of every library in a Nix runtime closure.

Both Linux build paths copy these notices into accessible files beside the game: `LICENSE.txt`, `THIRD_PARTY_NOTICES.md`, and `licenses/*.txt`. In the Nix package they are under `share/credence/`. Font and character grants also remain embedded in exported resources. The accompanying Linux font copies are `licenses/Alegreya-OFL.txt` and `licenses/Lato-OFL.txt`; character grants keep their `*-LICENSE.txt` names in Nix builds and have a `characters-` prefix in `tools/build.py` bundles.

The old installed binaries have not been changed. No licenses UI is added. Before any future binary publication, review the actual runtime and export-template dependencies and make their notices accessible for that platform. In particular, embedded Android asset notices alone have not been established as user-accessible; this source-only publication does not resolve APK distribution compliance.

## Optional headless input tooling

`tools/headless-seat.c` and `.py` derive from Simon W. Jackson's own tooling in the local `decompile/bw2` repository at commit `d900362b8dd75d70bcab9c4184d9f7400f175470`, under `scripts/`. That provenance does not make them commercial Black & White 2 game code. The generic helper is original work covered by `LICENSE.txt`.

When run, the Python helper downloads two SHA-256-checked Wayland protocol XML files and generates temporary client code. Those schemas and generated code retain their permissive upstream terms, not Credence's reservation:

| Protocol | Copyright holders | Verbatim notice |
|---|---|---|
| `virtual-keyboard-unstable-v1` | Kristian Høgsberg; Intel Corporation; Collabora, Ltd.; Purism SPC | [License](licenses/virtual-keyboard-unstable-v1-LICENSE.txt) |
| `wlr-virtual-pointer-unstable-v1` | Josef Gajdusek | [License](licenses/wlr-virtual-pointer-unstable-v1-LICENSE.txt) |

The URLs and expected hashes remain in `tools/headless-seat.py`. Neither the downloaded schemas nor generated helper executables are included in this source publication. Wayland and libxkbcommon are external build/link dependencies with their own terms. The helper is optional test tooling, not a game runtime dependency.
