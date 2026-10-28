#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later

set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
source_dir=${1:-"${XDG_CACHE_HOME:-$HOME/.cache}/kde-plasma-systray-order/plasma-workspace-v6.7.5"}

if [[ -e "$source_dir" ]]; then
    printf 'Refusing to overwrite existing path: %s\n' "$source_dir" >&2
    exit 1
fi

mkdir -p -- "$(dirname -- "$source_dir")"
git clone --depth 1 --branch v6.7.5 \
    https://invent.kde.org/plasma/plasma-workspace.git "$source_dir"

for patch in "$project_root"/patches/v6.7.5/*.patch; do
    git -C "$source_dir" apply --check "$patch"
    git -C "$source_dir" apply "$patch"
done

printf 'Prepared patched source tree:\n%s\n' "$source_dir"
