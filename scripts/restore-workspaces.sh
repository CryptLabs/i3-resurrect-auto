#!/bin/bash

# Restore all i3 workspaces from profiles
# https://github.com/YOUR_USERNAME/i3-resurrect-auto

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/config.sh"

# Wait for i3 to fully initialise
sleep "$RESTORE_DELAY"

# Check if profile directory exists
if [[ ! -d "$PROFILE_DIR" ]]; then
    echo "Profile directory not found: $PROFILE_DIR"
    exit 1
fi

# Restore each workspace from its corresponding profile
for num in "${!workspace_map[@]}"; do
    profile="${workspace_map[$num]}"
    
    # Check if profile exists before restoring
    if [[ -f "$PROFILE_DIR/${profile}_layout.json" ]]; then
        i3-resurrect restore -w "$num" -p "$profile" -d "$PROFILE_DIR"
    else
        echo "Profile not found: $profile"
    fi
done
