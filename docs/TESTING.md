# Test evidence and checklist

## Automated evidence

The focused build compiles `SortedSystemTrayModel`, `SystemTrayConfigModel`,
their generated settings class, and both QtTest suites. Results obtained on the
reference machine:

```text
Plasma 6.7.5 backport:                 2/2 suites passed
KDE MR 6958 + direct-drag extension:   2/2 suites passed
Complete official-ID applet build:     passed
Complete separate-ID applet build:     passed
qmllint exit status:                   0
```

Direct-move tests cover enabling manual mode, preserving absent IDs, and
ignoring invalid/no-op moves.

## Manual evidence

The separate applet was loaded by `plasmashell` on KDE Plasma 6.7.5 Wayland.
Its shared object was verified in `/proc/<plasmashell-pid>/maps`; the widget and
plugin survived a controlled shell restart. Direct drag was then validated by
the user in the real panel.

## Checklist for another system

- [ ] Normal clicks still activate icons.
- [ ] Visible icons reorder after crossing the drag threshold.
- [ ] Hidden popup icons reorder.
- [ ] The Entries page can drag and move by keyboard.
- [ ] Closing and reopening an application restores its place.
- [ ] A new application appears after saved items.
- [ ] Reset restores Plasma's default order.
- [ ] Show/Hide/Disabled choices are unchanged.
- [ ] Horizontal and vertical panels behave correctly.
- [ ] Order survives a controlled `plasmashell` restart.
- [ ] No new relevant errors appear in the user journal.
