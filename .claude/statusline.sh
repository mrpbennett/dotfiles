#!/usr/bin/env bash
# Claude Code status line
# Segments: cwd | git branch | model | context % | vim mode | session name | rate limits

input=$(cat)

# Parse all fields in one jq call. Fields are joined with \x1f (unit
# separator) rather than @tsv's tab: bash `read` treats tab as IFS
# whitespace and collapses consecutive delimiters, silently dropping
# empty fields (e.g. absent vim_mode/session_name shifting later fields).
IFS=$'\x1f' read -r cwd model_name ctx_pct ctx_tokens vim_mode session_name five_pct week_pct total_cost <<EOF
$(echo "$input" | jq -r '[
  (.workspace.current_dir // .cwd // ""),
  (.model.display_name // ""),
  (.context_window.used_percentage // ""),
  (.context_window.total_input_tokens // ""),
  (.vim.mode // ""),
  (.session_name // ""),
  (.rate_limits.five_hour.used_percentage // ""),
  (.rate_limits.seven_day.used_percentage // ""),
  (.cost.total_cost_usd // "")
] | join("")')
EOF

# Shorten home directory to ~
cwd="${cwd/#$HOME/~}"

# Git branch (skip optional locks, suppress errors)
branch=$(git --no-optional-locks -C "${cwd/#\~/$HOME}" branch --show-current 2>/dev/null)

# ANSI colors (printf-safe)
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
RED='\033[0;31m'
DIM='\033[2m'
RESET='\033[0m'
SEP="${DIM} | ${RESET}"

parts=()

# 1. Current working directory
[ -n "$cwd" ] && parts+=("$(printf "${CYAN}%s${RESET}" "$cwd")")

# 2. Git branch
[ -n "$branch" ] && parts+=("$(printf "${GREEN}%s${RESET}" "$branch")")

# 3. Model name
[ -n "$model_name" ] && parts+=("$(printf "${BLUE}%s${RESET}" "$model_name")")

# 4. Context window usage
if [ -n "$ctx_pct" ] && [ "$ctx_pct" != "null" ]; then
  ctx_int=$(printf "%.0f" "$ctx_pct")
  if [ "$ctx_int" -ge 80 ]; then
    ctx_color="$RED"
  elif [ "$ctx_int" -ge 50 ]; then
    ctx_color="$YELLOW"
  else
    ctx_color="$GREEN"
  fi
  if [ -n "$ctx_tokens" ] && [ "$ctx_tokens" != "null" ]; then
    ctx_fmt=$(printf "%.0f" "$ctx_tokens" | rev | sed 's/[0-9]\{3\}/&,/g;s/,$//' | rev)
    parts+=("$(printf "${ctx_color}🔥 %s tokens${RESET}" "$ctx_fmt")")
  fi
  parts+=("$(printf "${ctx_color}🧠 %s%% used${RESET}" "$ctx_int")")
fi

# 4b. Session cost
if [ -n "$total_cost" ] && [ "$total_cost" != "null" ]; then
  cost_fmt=$(awk -v c="$total_cost" 'BEGIN { printf "%.2f", c }')
  parts+=("$(printf "${GREEN}💰 \$%s spent${RESET}" "$cost_fmt")")
fi

# 5. Vim mode (only when present)
[ -n "$vim_mode" ] && parts+=("$(printf "${MAGENTA}%s${RESET}" "$vim_mode")")

# 6. Session name (only after /rename)
[ -n "$session_name" ] && parts+=("$(printf "${DIM}%s${RESET}" "$session_name")")

# 7. Rate limits (5-hour and 7-day)
rate_parts=()
if [ -n "$five_pct" ] && [ "$five_pct" != "null" ]; then
  rate_parts+=("$(printf "5h:%.0f%%" "$five_pct")")
fi
if [ -n "$week_pct" ] && [ "$week_pct" != "null" ]; then
  rate_parts+=("$(printf "7d:%.0f%%" "$week_pct")")
fi
if [ ${#rate_parts[@]} -gt 0 ]; then
  rate_str=$(
    IFS=' '
    echo "${rate_parts[*]}"
  )
  parts+=("$(printf "${YELLOW}%s${RESET}" "$rate_str")")
fi

# Join all parts with separator
result=""
for part in "${parts[@]}"; do
  if [ -z "$result" ]; then
    result="$part"
  else
    result="${result}${SEP}${part}"
  fi
done

printf "%b\n" "$result"
