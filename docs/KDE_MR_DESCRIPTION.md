# System Tray: allow dragging icons to reorder

## Summary

This adds direct drag-to-reorder behavior for System Tray icons in both the
visible panel and the hidden-items popup. It is designed as an optional
extension on top of !6958, preserving that MR's Entries-page controls,
persistence model, reset behavior, and accessibility.

The drag starts only after `QStyleHints::startDragDistance`, so an ordinary
click continues to activate the item normally.

## Implementation

- Add a `DragHandler` to the shared `AbstractItem` delegate used by visible and
  hidden tray items.
- Map indexes from each filtered QML model back to `SortedSystemTrayModel`.
- Validate the model indexes at the `SystemTray` C++ boundary.
- Move the selected ID in the persisted manual order and enable manual mode.
- Preserve IDs for temporarily absent applications while merging the new
  visible order.

## Tests

Three model tests cover:

- enabling manual order on the first direct move;
- preserving an absent saved ID during a move;
- ignoring invalid and no-op moves.

Validation performed against !6958 head `14783f3f`:

```text
sortedsystemtraymodeltest:   Passed
systemtrayconfigmodeltest:  Passed
2/2 suites passed
```

The same gesture was built as a separately named applet and manually validated
on a real Plasma 6.7.5 Wayland panel, including persistence across a controlled
`plasmashell` restart.

## Relationship to existing work

This is not a competing manual-order implementation. It depends on and credits
the persistence/configuration work in !6958 by Ramil Nurmanov, and only adds the
direct interaction requested by users in Bug 384782.

Related:

- Bug 384782
- !6958
- Reproducible patch and test evidence:
  https://github.com/e-kala/kde-plasma-systray-order
- Public review branch:
  https://github.com/e-kala/plasma-workspace/tree/feature/system-tray-direct-drag-mr6958
