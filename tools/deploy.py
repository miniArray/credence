#!/usr/bin/env nix-shell
#!nix-shell -i python3 -p python3 openssh
"""Copy the pinned runtime and verified pack without touching Korri or BW2."""

import json
import os
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[1]
HOST = "simonwjackson@aka"
BUNDLE = ROOT / "build/credence"
manifest = json.loads((BUNDLE / "manifest.json").read_text())
upload = "/tmp/credence-upload-" + str(os.getpid())
subprocess.run(
    ["nix", "copy", "--to", "ssh://" + HOST, manifest["runtime"]], check=True
)
subprocess.run(["scp", "-q", "-r", str(BUNDLE), HOST + ":" + upload], check=True)
installer = ROOT / "tools/install-release.py"
subprocess.run(
    ["scp", "-q", str(installer), HOST + ":/tmp/credence-install-release.py"],
    check=True,
)
subprocess.run(
    ["ssh", "-o", "BatchMode=yes", HOST, "/tmp/credence-install-release.py", upload],
    check=True,
)
# This directory belongs solely to the new prototype. Only copy our tool files.
subprocess.run(
    ["scp", "-q", "-r", str(ROOT / "tools"), HOST + ":.local/share/credence/"],
    check=True,
)
print("DEPLOYED ~/.local/share/credence/current/launch on " + HOST)
