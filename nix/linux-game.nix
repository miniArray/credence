{
  buildPkgs,
  runtimePkgs,
  source,
}:
let
  exporter =
    assert buildPkgs.godot.version == "4.6.1-stable";
    buildPkgs.godot;
  runtime =
    assert runtimePkgs.godot.version == "4.6.1-stable";
    runtimePkgs.godot;
  gameSource = buildPkgs.lib.fileset.toSource {
    root = source;
    fileset = buildPkgs.lib.fileset.unions [
      (source + /assets)
      (source + /game)
      (source + /sim)
      (source + /ui)
      (source + /project.godot)
      (source + /export_presets.cfg)
      (source + /LICENSE.txt)
      (source + /THIRD_PARTY_NOTICES.md)
      (source + /licenses)
    ];
  };
  # Export once on the build workstation. PCK data contains no native executable.
  pack =
    buildPkgs.runCommand "credence-linux-pack"
      {
        nativeBuildInputs = [ exporter ];
      }
      ''
        export HOME="$TMPDIR/home"
        export XDG_CONFIG_HOME="$HOME/config"
        export XDG_DATA_HOME="$HOME/data"
        export XDG_CACHE_HOME="$HOME/cache"
        mkdir -p "$XDG_CONFIG_HOME/godot" "$XDG_DATA_HOME" "$XDG_CACHE_HOME"
        cat > "$XDG_CONFIG_HOME/godot/editor_settings-4.6.tres" <<'SETTINGS'
        [gd_resource type="EditorSettings" format=3]

        [resource]
        export/android/shutdown_adb_on_exit = false
        SETTINGS
        cp -r ${gameSource} source
        chmod -R u+w source
        cd source
        rm -f assets/characters/curate.py assets/characters/provenance.json
        # Retain desktop formats and include ETC2/ASTC for ARM GLES/Vulkan drivers.
        sed -i '0,/texture_format\/etc2_astc=false/s//texture_format\/etc2_astc=true/' export_presets.cfg
        godot --headless --path . --editor --import --quit > import.log 2>&1
        cat import.log
        if grep -E 'SCRIPT ERROR:|^ERROR:' import.log; then exit 1; fi
        mkdir -p "$out/licenses"
        godot --headless --path . --export-pack Linux "$out/credence.pck" > export.log 2>&1
        cat export.log
        if grep -E 'SCRIPT ERROR:|^ERROR:' export.log; then exit 1; fi
        cp assets/fonts/*OFL.txt assets/characters/*LICENSE.txt licenses/*.txt "$out/licenses/"
        cp LICENSE.txt THIRD_PARTY_NOTICES.md "$out/"
        godot --headless --main-pack "$out/credence.pck" --quit-after 8 -- --no-intro --mute > smoke.log 2>&1
        cat smoke.log
        if grep -E 'SCRIPT ERROR:|^ERROR:' smoke.log; then exit 1; fi
      '';
in
buildPkgs.runCommand "credence"
  {
    passthru = { inherit pack runtime; };
    meta = {
      description = "Credence, a 3D village simulation";
      mainProgram = "credence";
      license = buildPkgs.lib.licenses.unfree;
    };
  }
  ''
    mkdir -p "$out/bin" "$out/share/credence"
    ln -s ${pack}/credence.pck "$out/share/credence/credence.pck"
    ln -s ${pack}/licenses "$out/share/credence/licenses"
    ln -s ${pack}/LICENSE.txt "$out/share/credence/LICENSE.txt"
    ln -s ${pack}/THIRD_PARTY_NOTICES.md "$out/share/credence/THIRD_PARTY_NOTICES.md"
    cat > "$out/bin/credence" <<'LAUNCHER'
    #!${runtimePkgs.runtimeShell}
    pack=${pack}/credence.pck
    if [ "''${1:-}" = --main-pack ]; then
      if [ "$#" -lt 2 ]; then
        printf '%s\n' 'Credence: --main-pack needs a file path' >&2
        exit 1
      fi
      pack="$2"
      shift 2
    fi
    if [ ! -f "$pack" ] || [ ! -r "$pack" ]; then
      printf '%s\n' 'Credence: game pack is missing or unreadable' >&2
      exit 1
    fi
    exec ${runtime}/bin/godot --main-pack "$pack" ${
      buildPkgs.lib.optionalString (
        runtimePkgs.stdenv.hostPlatform.system == "aarch64-linux"
      ) "--rendering-method gl_compatibility --rendering-driver opengl3_es"
    } "$@"
    LAUNCHER
    chmod +x "$out/bin/credence"
  ''
