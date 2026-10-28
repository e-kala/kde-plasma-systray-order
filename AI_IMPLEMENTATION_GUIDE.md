# AI implementation guide

This file is intentionally explicit and machine-readable enough for coding
agents. Do not rediscover or replace this design unless the target Plasma
version invalidates a listed invariant.

## Objective

Add persistent manual ordering to KDE Plasma's System Tray, with direct drag
for visible and hidden icons, without changing item visibility semantics.

## Known-good targets

```yaml
plasma_workspace_tag: v6.7.5
plasma_workspace_commit: cc1ab7963f94a9b76836412855caed6b94066188
upstream_manual_order_mr: 6958
tested_mr_head: 14783f3f60df6f3f44870ac6d82705d356aaa227
local_plugin_id: org.kde.plasma.systemtray.ordered
local_private_qml_uri: org.kde.plasma.private.systemtray.ordered
```

## Architecture map

```text
PlasmoidModel --------+
StatusNotifierModel --+--> SystemTrayModel --> SortedSystemTrayModel
BackgroundAppsModel --+                           |
                                                  +--> Active proxy --> panel GridView
                                                  +--> Passive proxy -> hidden popup GridView
                                                  +--> config model --> Entries page
```

There is one persisted order for all `itemId` values. Active/passive filtering
happens after sorting; never create separate visible/hidden order stores.

## Stable identity and persistence

- Plasmoids use their plugin ID.
- StatusNotifierItems use the normalized existing `itemId` role.
- Store a `QStringList` named `itemOrder` plus `manualItemOrder` mode.
- Never delete saved IDs merely because an application is temporarily absent.
- Append previously unseen IDs after known saved IDs.
- Preserve duplicate IDs by occurrence, matching `orderIndex()` semantics.

## Direct drag path

1. `AbstractItem.qml` owns a `DragHandler` with the platform
   `Application.styleHints.startDragDistance` threshold.
2. It finds the destination delegate through the parent `GridView`.
3. `main.qml` maps filtered proxy rows back to `SortedSystemTrayModel` indexes.
4. `SystemTray::moveItem()` validates both model indexes.
5. `SortedSystemTrayModel::move()` merges present and absent IDs, persists the
   new list, and enables manual mode.

Do not mutate visibility status during a move. Do not remove the normal
`MouseArea`; a click that does not cross the drag threshold must behave exactly
as before.

## Relevant files

```text
applets/systemtray/main.xml
applets/systemtray/systemtraysettings.{h,cpp}
applets/systemtray/systemtrayconfigmodel.{h,cpp}
applets/systemtray/sortedsystemtraymodel.{h,cpp}
applets/systemtray/systemtray.{h,cpp}
applets/systemtray/qml/ConfigGeneral.qml
applets/systemtray/qml/AbstractItem.qml
applets/systemtray/qml/main.qml
applets/systemtray/autotests/*systemtray*test.cpp
```

## Apply instead of recoding

For exact Plasma 6.7.5, apply every patch in lexical order:

```sh
git checkout v6.7.5
for patch in /path/to/kde-plasma-systray-order/patches/v6.7.5/*.patch; do
    git apply "$patch"
done
```

For work based on KDE MR 6958, apply only:

```text
patches/upstream-mr6958/direct-drag-on-mr6958.patch
```

## Required verification

- Build both focused test executables.
- Run `ctest --output-on-failure`.
- Compile the complete applet target, not only model tests.
- Run `qmllint` and distinguish dynamic Plasma-property warnings from syntax
  errors.
- Test visible drag, hidden-popup drag, normal click, app close/reopen, reset,
  new item insertion, and a controlled Plasma restart.
- Inspect the user journal after loading.

## Safety constraints

- Never edit or overwrite the official plugin in `/usr` for initial testing.
- Use the separately named applet first.
- Back up panel configuration before adding it.
- Do not restart KWin.
- Do not claim other Plasma/Qt versions are supported without rebuilding and
  running the full interaction checklist.

## Attribution constraint

Always credit Ramil Nurmanov and KDE MR 6958 for the original manual-ordering
implementation. Describe the direct-drag layer and 6.7.5 packaging as this
project's additions; do not present the whole implementation as newly authored.
