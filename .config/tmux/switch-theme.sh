#!/usr/bin/env bash
# Clear catppuccin's cached theme vars so the new flavor's colors apply.
# These are set with -ogq (only-if-not-set), so they must be unset first.
# Also clears @catppuccin_*_color vars (e.g. battery_color) which are -ogqF
# expanded at set time and would otherwise keep the old theme's hex values.
tmux show-options -gq | awk '{print $1}' \
    | grep -E '^@(thm_|_ctp_)|^@catppuccin_status_[a-z_]+_(icon|text)_(fg|bg)$|^@catppuccin_[a-z_]+_color$' \
    | while IFS= read -r opt; do
        tmux set -gu "$opt"
    done

tmux set -g @catppuccin_flavor "$1"
~/.config/tmux/plugins/tmux/catppuccin.tmux

# Rebuild status-right so it picks up the new @catppuccin_status_battery value.
# Without this, status-right keeps the baked-in colors from initial load (-agF).
tmux set -g status-right "#{E:@catppuccin_status_directory}"
tmux set -agF status-right "#{E:@catppuccin_status_battery}"

~/.config/tmux/plugins/tmux-battery/battery.tmux
