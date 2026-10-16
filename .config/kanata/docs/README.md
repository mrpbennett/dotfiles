# kanata on macOS

Keyboard remapping below the OS: home row mods with quick-tap, caps as Esc/Ctrl, and a nav layer. Keymap: [`../kanata.kbd`](../kanata.kbd). It replaced the old Karabiner-Elements config.

## Keymap

| Key | Tap | Hold |
| --- | --- | --- |
| caps | esc | ctrl (immediately, if another key is pressed) |
| a s d f | letter | ctrl opt cmd shift |
| j k l ; | letter | shift cmd opt ctrl |
| fn | — | cmd |
| left cmd | — | nav layer |
| cmd + bspc | opt + bspc (delete word) | |

Nav layer, while left cmd is held:

- h j k l → arrows
- with opt → opt + arrow
- with cmd, h/l → opt + left/right
- with ctrl → ctrl + fn + arrow
- bspc → forward delete; with cmd → ctrl + forward delete

Timing rules:

- **Quick-tap:** tap a home row key, then press and hold it again within 200ms, and the letter repeats. To hold `j` in vim, tap `j` and then hold it.
- **Prior-idle:** a home row key pressed within 150ms of another key is always a letter, so fast typing never fires a modifier.
- **Tuning:** `tap`, `hold` and `tap-hold-require-prior-idle` in `kanata.kbd`.

## How it fits together

```
keyboard → kanata (root, grabs the keyboard) → Karabiner VirtualHIDDevice driver → macOS
```

- **kanata** sends keys through a virtual keyboard provided by the **Karabiner-DriverKit-VirtualHIDDevice** driver.
- **Karabiner-Elements stays installed** because it ships that driver and runs its daemon.
- **Its own remapping must be switched off.** `../../karabiner/karabiner.json` sets every keyboard to `ignore`. Don't delete that file: Karabiner would recreate a default config, grab the keyboard again, and kanata would fail to start.

## Install (fresh machine)

### 1. Karabiner-Elements, for the driver

```sh
brew install --cask karabiner-elements
```

1. Open it once.
2. Approve the driver extension in System Settings → General → Login Items & Extensions → Driver Extensions.
3. Stow the dotfiles so `~/.config/karabiner/karabiner.json` (keyboards ignored) is in place. Or untick **Modify events** for every device in Karabiner → Settings → Devices.

Check that the driver daemon is running:

```sh
pgrep -fl Karabiner-VirtualHIDDevice-Daemon
```

### 2. kanata binary — match the driver version

kanata and the driver must speak the same protocol:

| Karabiner-Elements | Bundled driver | kanata |
| --- | --- | --- |
| 16.x | VirtualHIDDevice v8.x | **≥ 1.13** (prerelease as of Oct 2026) |
| 15.x | v5–v6 | 1.8 – 1.12 |

`brew install kanata` gave 1.12 at the time of writing, which **does not work** with Karabiner 16. Use a GitHub release instead:

```sh
cd "$(mktemp -d)"
gh release download <tag> -R jtroo/kanata -p 'macos-binaries-arm64.zip'
unzip macos-binaries-arm64.zip
sudo install -m 755 kanata_macos_arm64 /usr/local/bin/kanata
kanata --version
```

Pick the tag from https://github.com/jtroo/kanata/releases. Use `kanata_macos_arm64`, not the `cmd_allowed` variant, unless you need `cmd` actions.

### 3. Permissions

Open System Settings → Privacy & Security, and in **both** Accessibility and Input Monitoring:

1. Click **+**.
2. Press **⌘⇧G** and enter `/usr/local/bin/kanata`. Finder hides `/usr/local/bin`.
3. Make sure the toggle is on.

After **any** binary upgrade or replacement, remove the old entries and add the binary again. macOS pins permissions to the exact binary.

### 4. macOS's own modifier remaps

System Settings → Keyboard → Keyboard Shortcuts… → **Modifier Keys**: set everything back to its default, for **every keyboard** in the dropdown. macOS applies these before kanata sees the key. For example, Caps Lock → Escape here means kanata never sees caps, so hold-for-ctrl breaks.

### 5. Link config and start the daemon

```sh
cd ~/.dotfiles && stow --no-folding --dir=. --target="$HOME" .
kanata --check -c ~/.config/kanata/kanata.kbd
sudo install -m 644 -o root -g wheel ~/.config/kanata/dev.kanata.kanata.plist /Library/LaunchDaemons/
sudo launchctl bootstrap system /Library/LaunchDaemons/dev.kanata.kanata.plist
tail -f /var/log/kanata.log      # want: "keyboard grabbed, entering event processing loop"
```

The daemon starts at boot (`RunAtLoad`) and restarts if it crashes.

## Day to day

| Task | Command |
| --- | --- |
| Validate after editing | `kanata --check -c ~/.config/kanata/kanata.kbd` |
| Reload | `sudo launchctl kickstart -k system/dev.kanata.kanata` |
| Logs | `tail -f /var/log/kanata.log` |
| Stop (rollback) | `sudo launchctl bootout system/dev.kanata.kanata` |
| Start again | `sudo launchctl bootstrap system /Library/LaunchDaemons/dev.kanata.kanata.plist` |
| Emergency exit | `lctl + spc + esc` (physical keys) |

To roll back to Karabiner completely:

1. Stop the daemon.
2. Turn **Modify events** back on in Karabiner → Settings → Devices.
3. Restore the old config: `git log -- .config/karabiner/karabiner.json`.

## Troubleshooting

**"kanata needs macOS Accessibility permission" even though it's granted**

- **Started from a terminal with `sudo`?** macOS checks the *terminal app* (Ghostty), not kanata. Run it via the launchd daemon instead, or grant the terminal Accessibility too.
- **Another kanata is already running?** It holds the keyboard, and the second one gets "not permitted". Check with `pgrep -fl kanata`. A failed foreground run can sit at "Press enter to exit", so press Enter in that window. Don't `sudo pkill kanata` while the daemon is running, because that kills the daemon too.
- **Upgraded the binary?** Remove its permission entries and add them again.

**Other problems**

- **`sudo` fails inside Claude Code's `!` prompt:** it can't read a password there. Use a real terminal window.
- **A key does the wrong thing, or nothing:** check macOS Modifier Keys (step 4). Then run `sudo launchctl bootout system/dev.kanata.kanata && sudo kanata --debug -c ~/.config/kanata/kanata.kbd` from a terminal (with the permission caveat above) to see raw key events.
- **Driver errors in the log** (`driver connected: false` that never turns true, or a version mismatch): kanata and the driver versions don't match. See step 2.

## Not ported from Karabiner

Fn+bspc → cmd+bspc in Finder only. kanata has no per-app conditions, and cmd+bspc already moves files to the Trash in Finder.
