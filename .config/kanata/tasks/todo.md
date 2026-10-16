# Migrate Karabiner-Elements → kanata (home row mods with quick-tap)

## Decisions
- Config: `~/.dotfiles/.config/kanata/kanata.kbd` (stowed → `~/.config/kanata/`)
- Karabiner-Elements stays installed (provides VirtualHIDDevice driver 8.5.0 + daemon); its grabbing is disabled
- kanata **v1.13.0-prerelease-1** arm64 binary (brew's 1.12.0 speaks the old v6 driver protocol — incompatible)
- caps: tap Esc / hold Ctrl
- HRM both hands: a s d f = ctrl opt cmd shift; j k l ; = shift cmd opt ctrl
- Nav layer key: hold left cmd (fn key → cmd)

## Config spec (`kanata.kbd`)
- [x] HRM via `tap-hold-release` 200/200 — first param = quick-tap window: tap then hold → letter repeats (fixes vim jjjj)
- [x] `tap-hold-require-prior-idle 150` — fast typing never triggers mods
- [x] built-in fn → left cmd (was Karabiner simple_modification)
- [x] cmd+bspc → opt+bspc (`fork` + `unmod`)
- [x] nav layer: hjkl → arrows; +opt → opt+arrow (passthrough); +cmd h/l → opt+left/right; +ctrl hjkl → ctrl+fn+arrow; bspc → fwd delete; +cmd bspc → ctrl+fwd delete
- [x] Dropped: Finder-only Fn+bspc → cmd+bspc (kanata has no per-app conditions; cmd+bspc already trashes in Finder natively)
- [x] `kanata --check` passes

## Install (needs sudo — user runs these via `!`)
- [x] Downloaded + sha256-verified release zip (scratchpad)
- [x] `sudo install` to `/usr/local/bin/kanata` (1.13.0-prerelease-2)
- [x] Disable Karabiner grabbing (Settings → Devices → Modify events off for all), confirm VHID daemon still running
- [x] Input Monitoring + Accessibility granted to /usr/local/bin/kanata (foreground sudo from Ghostty fails: TCC checks Ghostty as responsible process — use the daemon)
- [x] Test: typing rolls, cmd/ctrl shortcuts, tap-then-hold j repeats, nav layer, fn→cmd
- [x] launchd daemon `/Library/LaunchDaemons/dev.kanata.kanata.plist` (source tracked in dotfiles)
- [x] symlinked ~/.config/kanata/{kanata.kbd,dev.kanata.kanata.plist} (same as stow would; full stow also picks up stray .bak files)
- [x] docs: `.config/kanata/docs/README.md` (install, reload, rollback)

## Rollback
Stop kanata daemon (`sudo launchctl bootout system/dev.kanata.kanata`), re-enable Modify events in Karabiner.

## Risks
- Apple forum report: since macOS 26.4, built-in keyboard events may not reach DriverKit virtual HID; you're on 27 — smoke test before launchd
- fn key read/write in kanata on macOS is undocumented; F-row issue #975 open
- (resolved) Karabiner files cleaned up — see Review
- [x] macOS Modifier Keys had Caps Lock → Escape (hid remap before kanata) — reset to Caps Lock
- [x] caps: tap-hold-press + require-prior-idle 0 so fast caps+c = ctrl+c

## Cleanup
- [x] `karabiner.json` reduced to "ignore all keyboards" (driver only); copied to live `~/.config/karabiner/karabiner.json` (Karabiner replaces symlinks with real files). Old live file backed up to session scratchpad
- [x] Removed `karabiner.json.bak` (identical to HEAD) and tracked `automatic_backups/` (in git history)
- [x] This plan moved from `.config/karabiner/tasks/` → `.config/kanata/tasks/`
- [x] Dotfiles README table: added kanata row, karabiner row describes driver-only role
- [x] `.config/kanata/docs/README.md`: full macOS install/setup/troubleshooting guide

## Review
- Works: caps esc/ctrl, HRM both hands, tap-then-hold repeat (vim j), nav layer, fn→cmd, F-row — verified by user on device
- kanata runs as launchd daemon `dev.kanata.kanata`; log `/var/log/kanata.log`
- Gotchas hit: (1) brew kanata 1.12 incompatible with Karabiner 16 driver v8 → used 1.13 prerelease; (2) macOS Modifier Keys Caps→Esc hid caps from kanata; (3) `sudo kanata` from Ghostty fails TCC (Ghostty is responsible process) → daemon instead; (4) stale foreground instance held the keyboard
- Not committed (GitHub policy: read-only); user to review `git status` and commit
