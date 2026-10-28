# Upstream contribution route

KDE Bug 384782 is the canonical feature request. KDE Plasma Workspace MR 6958
is the active implementation of manual ordering in the Entries settings page.

This project's upstream contribution should therefore be reviewed as a small
extension on top of MR 6958, not as a competing reimplementation:

```text
patches/upstream-mr6958/direct-drag-on-mr6958.patch
```

It adds direct dragging in the visible panel and hidden popup, a validated C++
move boundary, preservation of absent IDs, and three focused tests.

Public review branch:

```text
https://github.com/e-kala/plasma-workspace/tree/feature/system-tray-direct-drag-mr6958
```

Before opening or updating an upstream MR:

1. Fetch the current MR 6958 head.
2. Rebase or reapply the one patch.
3. Run the focused tests and a complete Plasma Workspace CI build.
4. Coordinate with Ramil Nurmanov and preserve authorship/credit.
5. Link Bug 384782 and explain that direct dragging complements the accessible
   Entries-page controls rather than replacing them.
