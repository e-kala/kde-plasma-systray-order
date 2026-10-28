# Instructions for coding agents

Read `AI_IMPLEMENTATION_GUIDE.md` before modifying or reimplementing anything.
The working design, target commits, file map, invariants, patch sets, safety
constraints, and validation checklist are already documented there.

For Plasma Workspace 6.7.5, reuse `patches/v6.7.5/` in lexical order. For work
on top of KDE MR 6958, reuse only
`patches/upstream-mr6958/direct-drag-on-mr6958.patch` and rebase it onto the current
MR head.

Do not claim compatibility with another Plasma/Qt version merely because a
patch applies. Build the complete applet, run both QtTest suites, and execute
the manual interaction checklist in `docs/TESTING.md`.

Do not overwrite Plasma's official applet during initial testing. Preserve
attribution to Ramil Nurmanov and KDE MR 6958 for the base manual-ordering
implementation.
