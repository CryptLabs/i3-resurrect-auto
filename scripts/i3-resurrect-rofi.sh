#!/bin/bash

# Rofi menu for i3-resurrect operations
# https://github.com/YOUR_USERNAME/i3-resurrect-auto

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/config.sh"

ACTIONS=("Restore" "Save" "Delete" "Save All" "Restore All")
TARGETS=("Both" "Programs" "Layout")

# Use rofi in dmenu mode
DMENU="rofi -dmenu -i"

# Select action
prompt="i3-resurrect"
action=$(printf "%s\n" "${ACTIONS[@]}" | $DMENU -p "$prompt")

case $action in
    "Save All")
        "$SCRIPT_DIR/save-workspaces.sh"
        exit 0
        ;;
    "Restore All")
        "$SCRIPT_DIR/restore-workspaces.sh" &
        exit 0
        ;;
    Save)
        command="i3-resurrect save --swallow=$SWALLOW_CRITERIA -p"
        ;;
    Restore)
        command="i3-resurrect restore -p"
        ;;
    Delete)
        command="i3-resurrect rm -p"
        ;;
    *)
        echo "Invalid action"
        exit 1
        ;;
esac

# Select profile
prompt="Profile"
profile=$(i3-resurrect ls profiles -d "$PROFILE_DIR" 2>/dev/null | awk '{$NF=""; $1=""; print $0}' | uniq | $DMENU -p "$prompt" | xargs)

if [[ -z "$profile" ]]; then
    echo "Invalid profile"
    exit 1
fi

# Select target
prompt="Target"
target=$(printf "%s\n" "${TARGETS[@]}" | $DMENU -p "$prompt")

case $target in
    Programs)
        target_option="--programs-only"
        ;;
    Layout)
        target_option="--layout-only"
        ;;
    Both)
        target_option=""
        ;;
    *)
        echo "Invalid target"
        exit 1
        ;;
esac

# Execute command
$command "$profile" $target_option -d "$PROFILE_DIR"

# Send notification for save action
if [[ "$action" == "Save" ]] && command -v notify-send &> /dev/null; then
    notify-send "i3-resurrect" "Profile '$profile' saved"
fi
