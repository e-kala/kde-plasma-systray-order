# KDE Plasma System Tray Manual Order

Persistent manual ordering and direct drag-and-drop for KDE Plasma system tray
icons. This repository packages the implementation, tests, reproducible
patches, safe user-local installation, and an upstream-ready extension.

Search terms: **KDE Plasma reorder tray icons**, **manual systray order**,
**drag system tray icons**, **Plasma notification area icon order**.

[Documentacion en espanol](README.es.md) ·
[AI implementation guide](AI_IMPLEMENTATION_GUIDE.md) ·
[Architecture](docs/ARCHITECTURE.md) · [Testing](docs/TESTING.md)

## What works

- Drag visible icons directly in the panel.
- Drag hidden icons in the popup.
- Reorder every known item from System Tray Settings -> Entries.
- Keyboard-accessible move up/down controls.
- Persistent order based on stable `itemId` values.
- Temporarily absent applications recover their previous position.
- Newly discovered items are appended after the saved order.
- Reset to Plasma's original category/alphabetical ordering.
- Existing visibility choices and horizontal/vertical layouts remain intact.

The user-local variant has a separate plugin ID,
`org.kde.plasma.systemtray.ordered`, so it can coexist with Plasma's official
System Tray without replacing files in `/usr`.

## Supported and tested

| Target | Status |
| --- | --- |
| Plasma Workspace `v6.7.5` | Built, QtTest-passed, and manually validated on Wayland |
| KDE MR 6958 head `14783f3f` | Direct-drag extension applies cleanly; 2/2 focused suites pass |
| Other Plasma versions | Not yet claimed; rebuild and test against the exact version |

The live test covered direct dragging, loading the separately named applet,
and persistence across a controlled `plasmashell` restart on Plasma 6.7.5.

## Quick path for Plasma 6.7.5

Prerequisites are a C++ compiler, CMake, Git, Qt 6/KF6/Plasma development
headers, and Extra CMake Modules compatible with the installed Plasma stack.

```sh
git clone https://github.com/e-kala/kde-plasma-systray-order.git
cd kde-plasma-systray-order
./scripts/quick-install-v6.7.5.sh
```

The script clones the exact KDE tag, applies the reviewed patch series, builds
only the applet, and installs only the separately named plugin under
`~/.local`. It does **not** use `sudo`, overwrite the official plugin, change a
panel, or restart Plasma. Read [the installation guide](docs/INSTALL.md) before
activating it.

If ECM is installed in a private prefix:

```sh
ECM_PREFIX=/path/to/ecm-prefix ./scripts/quick-install-v6.7.5.sh
```

## Patch sets

- `patches/v6.7.5/`: complete backport, direct drag, focused build harness,
  and separate applet identity for safe local use.
- `patches/upstream-mr6958/`: one small direct-drag commit intended to sit on
  top of KDE's active manual-ordering MR.

The same upstream-ready commit is browsable as a normal Plasma Workspace
branch in the [public KDE mirror fork](https://github.com/e-kala/plasma-workspace/tree/feature/system-tray-direct-drag-mr6958).

## Upstream relationship and credit

The settings UI, persistence model, reset behavior, and original tests are a
backport/adaptation of [KDE Plasma Workspace MR 6958](https://invent.kde.org/plasma/plasma-workspace/-/merge_requests/6958),
authored by **Ramil Nurmanov**. This project adds the direct panel/popup drag
gesture, Plasma 6.7.5 adaptation, isolated build/test tooling, safe coexisting
plugin identity, and reproducible documentation.

The long-running upstream request is
[KDE Bug 384782](https://bugs.kde.org/show_bug.cgi?id=384782). This repository
does not replace the upstream review process; it preserves a tested route for
users while making the additional work easy to inspect and contribute.

## Safety

- Never replace `/usr/lib/qt6/plugins/plasma/applets/org.kde.plasma.systemtray.so`.
- Keep the official tray until the ordered tray is verified.
- Back up `plasma-org.kde.plasma.desktop-appletsrc` before changing a panel.
- Rebuild after Plasma or Qt updates because this applet uses internal Plasma
  implementation details.
- Use `scripts/uninstall-user.sh` to remove only this project's files.

## License

Modified KDE source files retain their SPDX licenses. Project scripts and
documentation are distributed under `GPL-2.0-or-later`; see [LICENSE](LICENSE).
