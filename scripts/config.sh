#!/bin/bash

# i3-resurrect-auto configuration
# Map workspace numbers/names to profile names

declare -A workspace_map=(
    ["1"]="Workspace1"
    ["2"]="Workspace2"
    ["3"]="Workspace3"
    ["4"]="Workspace4"
    ["5"]="Workspace5"
    ["6"]="Workspace6"
    ["7"]="Workspace7"
    ["8"]="Workspace8"
    ["9"]="Workspace9"
    ["10"]="Workspace10"
)

# Directory where profiles are saved
PROFILE_DIR="$HOME/.i3/i3-resurrect/profiles"

# Swallow criteria for saving (options: class, instance, title, window_role)
SWALLOW_CRITERIA="class,instance,title"

# Delay before restoring (seconds) - allows i3 to fully initialise
RESTORE_DELAY=2
