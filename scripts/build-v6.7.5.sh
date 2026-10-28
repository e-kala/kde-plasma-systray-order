#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later

set -euo pipefail

source_dir=${1:?Usage: build-v6.7.5.sh /path/to/patched/plasma-workspace [build-dir]}
build_dir=${2:-"${XDG_CACHE_HOME:-$HOME/.cache}/kde-plasma-systray-order/build-v6.7.5"}
ecm_prefix=${ECM_PREFIX:-}

cmake_args=(
    -S "$source_dir/dev/standalone-applet"
    -B "$build_dir"
    -DCMAKE_BUILD_TYPE=RelWithDebInfo
)
if [[ -n "$ecm_prefix" ]]; then
    cmake_args+=("-DCMAKE_PREFIX_PATH=$ecm_prefix")
fi

cmake "${cmake_args[@]}"
cmake --build "$build_dir" --target org.kde.plasma.systemtray.ordered -j"$(nproc)"

printf 'Built plugin:\n%s\n' \
    "$build_dir/bin/plasma/applets/org.kde.plasma.systemtray.ordered.so"
