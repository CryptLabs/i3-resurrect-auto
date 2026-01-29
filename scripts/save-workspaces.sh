#!/bin/bash

# Save all i3 workspaces to profiles
# https://github.com/YOUR_USERNAME/i3-resurrect-auto

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/config.sh"

# Ensure profile directory exists
mkdir -p "$PROFILE_DIR"

# Save each workspace to its corresponding profile
for num in "${!workspace_map[@]}"; do
    profile="${workspace_map[$num]}"
    i3-resurrect save --swallow="$SWALLOW_CRITERIA" -w "$num" -p "$profile" -d "$PROFILE_DIR"
done

# Optional: send notification
if command -v notify-send &> /dev/null; then
    notify-send "i3-resurrect" "Workspaces saved successfully"
fi
