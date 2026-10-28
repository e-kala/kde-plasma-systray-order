# Coordination message for the MR 6958 maintainer

Hi Ramil,

Thank you for the manual System Tray ordering work in !6958. I adapted it to
Plasma 6.7.5 for a real-user test and added one complementary feature: dragging
icons directly in both the visible panel and the hidden-items popup.

I have kept the direct-drag change as a single commit on top of your current MR
head (`14783f3f`), rather than publishing a competing implementation. It applies
without conflicts, and both focused QtTest suites pass. The same code was built
as a separately named applet and validated on a Plasma 6.7.5 Wayland panel,
including a controlled shell restart.

Would you prefer this as a follow-up MR targeting your branch, a commit you can
cherry-pick, or a separate MR after !6958 lands?

Patch, test evidence, architecture notes, and attribution are available here:
https://github.com/e-kala/kde-plasma-systray-order

The one-commit review branch is here:
https://github.com/e-kala/plasma-workspace/tree/feature/system-tray-direct-drag-mr6958
