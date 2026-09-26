#!/usr/bin/env bash

# colors (tmux format)
gray_light="#FAFAFA"
gray_medium="#E5E5E6"
gray_dark="#383A42"
red_soft="#E45649"
green_soft="#50A14F"
yellow_soft="#C18401"
blue_muted="#4078F2"
cyan_soft="#0184BC"

branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || exit 0

# upstream ahead/behind
counts=$(git rev-list --left-right --count HEAD...@{upstream} 2>/dev/null)
ahead=$(echo $counts | awk '{print $1}')
behind=$(echo $counts | awk '{print $2}')

# staged / unstaged
git diff --cached --quiet 2>/dev/null || staged=1
git diff --quiet 2>/dev/null || unstaged=1

# build status
status=""

[ "$staged" ] && status="${status}#[fg=${green_soft}] "
[ "$unstaged" ] && status="${status}#[fg=${red_soft}] "

[ "$ahead" -gt 0 ] 2>/dev/null && status="${status}#[fg=${blue_muted}] $ahead "
[ "$behind" -gt 0 ] 2>/dev/null && status="${status}#[fg=${yellow_soft}] $behind "

# branch icon
printf "#[fg=${blue_muted}] %s %s#[default]" "$branch" "$status"
