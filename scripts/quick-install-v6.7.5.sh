#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later

set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
cache_root=${XDG_CACHE_HOME:-"$HOME/.cache"}/kde-plasma-systray-order
source_dir="$cache_root/plasma-workspace-v6.7.5"
build_dir="$cache_root/build-v6.7.5"

"$project_root/scripts/prepare-v6.7.5.sh" "$source_dir"
"$project_root/scripts/build-v6.7.5.sh" "$source_dir" "$build_dir"
"$project_root/scripts/install-user.sh" \
    "$build_dir/bin/plasma/applets/org.kde.plasma.systemtray.ordered.so"

printf '%s\n' \
    'Build and user-local installation completed.' \
    'Read docs/INSTALL.md before activating the widget.'
