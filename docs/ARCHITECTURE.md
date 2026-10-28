# Architecture and design decisions

## Why one ordered source model

Plasma already combines plasmoids, StatusNotifierItems, and background
applications in `SystemTrayModel`. `SortedSystemTrayModel` sits above that
combined model, while active and passive models are only filters. Persisting
the order at the sorted-model level makes the panel, hidden popup, and Entries
page agree without changing the existing visibility machinery.

## Absent items

An application icon disappearing usually means the process exited, not that
the user revoked its position. `mergedOrder()` therefore overlays currently
present items on the saved list and leaves absent IDs in place. A later move
repositions the selected visible item while retaining those absent anchors.

## New items

Unlisted items retain Plasma's default relative sort and follow every listed
item. Once the order is saved again, they become part of the persistent list.

## Filter-to-source mapping

Visible and hidden `GridView`s use separate `KSortFilterProxyModel` instances.
The drag gesture cannot send their row numbers directly to the C++ sorter.
`main.qml` calls `mapToSource()` for both indexes, and `SystemTray::moveItem()`
rejects indexes that do not belong to its `SortedSystemTrayModel`.

## Coexisting test applet

The user-local build changes both public identities:

```text
org.kde.plasma.systemtray -> org.kde.plasma.systemtray.ordered
org.kde.plasma.private.systemtray -> org.kde.plasma.private.systemtray.ordered
```

It also skips legacy containment migration when the plugin ID is not the
official one. This prevents a development applet from consuming or deleting
configuration owned by Plasma's built-in tray.
