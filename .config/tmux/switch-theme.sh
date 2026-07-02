#!/usr/bin/env bash
# Clear catppuccin's cached theme vars so the new flavor's colors apply.
# These are set with -ogq (only-if-not-set), so they must be unset first.
tmux show-options -gq | awk '{print $1}' \
    | grep -E '^@(thm_|_ctp_)|^@catppuccin_status_[a-z_]+_(icon|text)_(fg|bg)$' \
    | while IFS= read -r opt; do
        tmux set -gu "$opt"
    done

tmux set -g @catppuccin_flavor "$1"
~/.config/tmux/plugins/tmux/catppuccin.tmux
~/.config/tmux/plugins/tmux-battery/battery.tmux
