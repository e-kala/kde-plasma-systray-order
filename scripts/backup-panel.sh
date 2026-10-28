#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later

set -euo pipefail

config_home=${XDG_CONFIG_HOME:-"$HOME/.config"}
source_file="$config_home/plasma-org.kde.plasma.desktop-appletsrc"
state_home=${XDG_STATE_HOME:-"$HOME/.local/state"}
timestamp=$(date +%Y%m%d-%H%M%S)
backup_dir="$state_home/plasma-systray-ordered/backups/$timestamp"

if [[ ! -f "$source_file" ]]; then
    printf 'Panel configuration not found: %s\n' "$source_file" >&2
    exit 1
fi

install -d -- "$backup_dir"
cp -a -- "$source_file" "$backup_dir/"
sha256sum -- "$backup_dir/$(basename -- "$source_file")" >"$backup_dir/SHA256SUMS"
printf 'Backup created:\n%s\n' "$backup_dir"
