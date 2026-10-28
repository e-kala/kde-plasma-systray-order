#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later

set -euo pipefail

artifact=${1:?Usage: install-user.sh /path/to/org.kde.plasma.systemtray.ordered.so}
plugin_root=${ORDERED_TRAY_PLUGIN_ROOT:-"$HOME/.local/lib/qt6/plugins"}
destination="$plugin_root/plasma/applets/org.kde.plasma.systemtray.ordered.so"
environment_dir=${XDG_CONFIG_HOME:-"$HOME/.config"}/environment.d
environment_file="$environment_dir/90-plasma-systray-ordered.conf"

if [[ ! -f "$artifact" ]]; then
    printf 'Artifact not found: %s\n' "$artifact" >&2
    exit 1
fi
if [[ -e "$destination" ]]; then
    printf 'Refusing to overwrite: %s\n' "$destination" >&2
    exit 1
fi

install -Dm755 -- "$artifact" "$destination"
install -d -- "$environment_dir"
printf '%s\n' '# Added by kde-plasma-systray-order; remove with scripts/uninstall-user.sh' >"$environment_file"
printf 'QT_PLUGIN_PATH=%s:${QT_PLUGIN_PATH}\n' "$plugin_root" >>"$environment_file"

printf '%s\n' \
    "Installed: $destination" \
    "Environment: $environment_file" \
    'Plasma was not restarted and no panel was changed.'
