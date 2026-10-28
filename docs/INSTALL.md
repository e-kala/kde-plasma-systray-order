# Safe installation for Plasma 6.7.5

## 1. Prepare, build, and install

```sh
./scripts/quick-install-v6.7.5.sh
```

The resulting plugin is:

```text
~/.local/lib/qt6/plugins/plasma/applets/org.kde.plasma.systemtray.ordered.so
```

An `environment.d` entry adds that private plugin root to `QT_PLUGIN_PATH` for
the next login. No system file is replaced.

## 2. Back up the panel

```sh
./scripts/backup-panel.sh
```

Backups are written below
`~/.local/state/plasma-systray-ordered/backups/` with a checksum.

## 3. Activate

Log out and back in, then add **Ordered System Tray** / **Bandeja del sistema
ordenable** from Plasma's widget chooser. Keep the official System Tray until
the test checklist passes.

A controlled `plasma-plasmashell.service` restart is an alternative for
developers, but it should not be automated by an installer.

## 4. Remove

First remove the ordered widget from the panel, then run:

```sh
./scripts/uninstall-user.sh
```

Log out and back in. The script removes only the separately named plugin and
the environment file carrying this project's marker. It never edits the panel
configuration or `/usr`.
