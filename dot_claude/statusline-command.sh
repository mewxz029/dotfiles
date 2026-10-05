#!/bin/bash
# Claude Code status line: 3 lines, Catppuccin Mocha. Reads JSON on stdin.
input=$(cat)
j() { printf '%s' "$input" | jq -r "$1 // empty" 2>/dev/null; }

esc=$'\033'
rgb() { printf '%s[38;2;%s;%s;%sm' "$esc" "$1" "$2" "$3"; }
RST="${esc}[0m"
OVERLAY0=$(rgb 108 112 134); TEXT=$(rgb 205 214 244); MAUVE=$(rgb 203 166 247)
SUB0=$(rgb 166 173 200);     BLUE=$(rgb 137 180 250); PEACH=$(rgb 250 179 135)
GREEN=$(rgb 166 227 161);    YELLOW=$(rgb 249 226 175); RED=$(rgb 243 139 168)

ICON_FOLDER=$'\xef\x81\xbb'   # U+F07B
ICON_BRANCH=$'\xee\x82\xa0'   # U+E0A0
ICON_STAR=$'\xe2\x9c\xb1'     # U+2731
ICON_EFFORT=$'\xe2\x97\x8f'   # U+25CF
ICON_FAST=$'\xe2\x9a\xa1'     # U+26A1

BAR_W=30
# color_for PCT -> threshold color (green <50, yellow 50-80, red >80)
color_for() {
  awk -v p="$1" -v g="$GREEN" -v y="$YELLOW" -v r="$RED" \
    'BEGIN{ if (p>80) printf "%s", r; else if (p>=50) printf "%s", y; else printf "%s", g }'
}
# bar PCT(or empty)
bar() {
  local pct="$1" filled=0 i out="" col
  if [ -n "$pct" ]; then
    filled=$(awk -v p="$pct" -v w="$BAR_W" 'BEGIN{ if(p<0)p=0; if(p>100)p=100; printf "%d", (p*w/100)+0.5 }')
    col=$(color_for "$pct")
    out="$col"
    for ((i = 0; i < filled; i++)); do out+="━"; done
  fi
  out+="$OVERLAY0"
  for ((i = filled; i < BAR_W; i++)); do out+="─"; done
  printf '%s%s' "$out" "$RST"
}
# row LABEL PCT FORMAT  -> "Label: bar pct" (pct padded to 6 cols)
row() {
  local label="$1" pct="$2" fmt="$3" txt col
  if [ -n "$pct" ]; then
    txt=$(printf "$fmt" "$pct"); col=$(color_for "$pct")
  else
    txt="--"; col="$OVERLAY0"
  fi
  printf '%s%s%s %s %s%-6s%s' "$OVERLAY0" "$label" "$RST" "$(bar "$pct")" "$col" "$txt" "$RST"
}

ctx=$(j '.context_window.used_percentage')
five=$(j '.rate_limits.five_hour.used_percentage')
week=$(j '.rate_limits.seven_day.used_percentage')
model=$(j '.model.display_name')
effort=$(j '.effort.level')
style=$(j '.output_style.name')
fast=$(printf '%s' "$input" | jq -r 'if .fast_mode == true then "1" else empty end' 2>/dev/null)
added=$(j '.cost.total_lines_added')
removed=$(j '.cost.total_lines_removed')
cwd=$(j '.workspace.current_dir'); [ -z "$cwd" ] && cwd=$(j '.cwd')

# Line 1
l1=$(row "Ctx :" "$ctx" '%.1f%%')
[ -n "$fast" ] && l1+=" ${YELLOW}${ICON_FAST}fast${RST}"
[ -n "$model" ] && l1+=" ${MAUVE}${ICON_STAR} ${model}${RST}"
[ -n "$effort" ] && l1+=" ${SUB0}${ICON_EFFORT} ${effort}${RST}"
[ -n "$style" ] && [ "$style" != "default" ] && l1+=" ${TEXT}${style}${RST}"
printf '%s\n' "$l1"

# Line 2
l2=$(row "5-hr:" "$five" '%.0f%%')
if [ -n "$cwd" ]; then
  disp="$cwd"
  case "$cwd" in "$HOME"|"$HOME"/*) disp="~${cwd#"$HOME"}" ;; esac
  l2+=" ${BLUE}${ICON_FOLDER} ${disp}${RST}"
fi
printf '%s\n' "$l2"

# Line 3
l3=$(row "Week:" "$week" '%.0f%%')
if [ -n "$cwd" ] && git -C "$cwd" --no-optional-locks rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short -q HEAD 2>/dev/null \
    || git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    l3+=" ${PEACH}${ICON_BRANCH} ${branch}${RST}"
    if [ -z "$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)" ]; then
      l3+=" ${GREEN}✓${RST}"
    else
      l3+=" ${YELLOW}●${RST}"
    fi
  fi
fi
[ -n "$added" ] && l3+=" ${GREEN}${added}+${RST}"
[ -n "$removed" ] && l3+=" ${RED}${removed}-${RST}"
printf '%s\n' "$l3"
