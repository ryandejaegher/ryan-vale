#!/usr/bin/env bash

set -euo pipefail

repo_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
dist_dir="$repo_root/dist"

rm -rf "$dist_dir"
mkdir -p "$dist_dir"

REPO_ROOT="$repo_root" DIST_DIR="$dist_dir" python3 - <<'PY'
import os
from pathlib import Path
from zipfile import ZIP_DEFLATED, ZipFile

repo_root = Path(os.environ["REPO_ROOT"])
dist_dir = Path(os.environ["DIST_DIR"])
package_root = repo_root / "ryan-vale"

with ZipFile(dist_dir / "ryan-vale.zip", "w", ZIP_DEFLATED) as archive:
    for path in package_root.rglob("*"):
        if path.is_file():
            archive.write(path, path.relative_to(repo_root))
PY

printf 'Created %s\n' "$dist_dir/ryan-vale.zip"
