#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later

set -euo pipefail

plugin_root=${ORDERED_TRAY_PLUGIN_ROOT:-"$HOME/.local/lib/qt6/plugins"}
plugin_file="$plugin_root/plasma/applets/org.kde.plasma.systemtray.ordered.so"
environment_file=${XDG_CONFIG_HOME:-"$HOME/.config"}/environment.d/90-plasma-systray-ordered.conf

if [[ -f "$environment_file" ]] && ! grep -q '^# Added by kde-plasma-systray-order' "$environment_file"; then
    printf 'Refusing to remove an unrecognized environment file: %s\n' "$environment_file" >&2
    exit 1
fi

rm -f -- "$plugin_file"
if [[ -f "$environment_file" ]]; then
    rm -f -- "$environment_file"
fi

printf '%s\n' \
    'Removed only the ordered plugin and its marked environment file.' \
    'No panel configuration or system file was changed.'
