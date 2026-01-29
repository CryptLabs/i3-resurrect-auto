# i3-resurrect-auto

Automatically save and restore i3 workspaces, layouts, and applications using [i3-resurrect](https://github.com/JonnyHaystack/i3-resurrect).

## Features

- **Automatic saving** on shutdown, reboot, and logout via rofi power menu integration
- **Automatic restoration** on i3 startup
- **Named profiles** for organised workspace management
- **Rofi menu** for manual save/restore/delete operations

## Prerequisites

- [i3wm](https://i3wm.org/)
- [i3-resurrect](https://github.com/JonnyHaystack/i3-resurrect)
- [rofi](https://github.com/davatorium/rofi)
- bash

### Installing i3-resurrect

**Arch Linux (AUR):**

```bash
yay -S i3-resurrect
```

**pip:**

```bash
pip install i3-resurrect
```

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/CryptLabs/i3-resurrect-auto.git
   cd i3-resurrect-auto
   ```

2. **Run the install script:**

   ```bash
   chmod +x install.sh
   ./install.sh
   ```

   This will:
   - Copy scripts to `~/.config/i3/scripts/`
   - Make them executable
   - Create the i3-resurrect profiles directory

3. **Configure your workspace mapping:**

   Edit `~/.config/i3/scripts/config.sh` and map your workspace numbers to profile names:

   ```bash
   declare -A workspace_map=(
       ["1"]="Workspace1"
       ["2"]="Workspace2"
       ["3"]="Workspace3"
       # Add more mappings as needed
   )
   ```

4. **Add to your i3 config:**

   Add the following to `~/.config/i3/config`:

   ```
   # Restore workspaces on startup
   exec --no-startup-id ~/.config/i3/scripts/restore-workspaces.sh

   # Optional: keybinding for rofi i3-resurrect menu
   bindsym $mod+Shift+r exec --no-startup-id ~/.config/i3/scripts/i3-resurrect-rofi.sh
   ```

5. **Integrate with your power menu:**

   In your rofi power menu script, add the save command before shutdown/reboot/logout actions:

   ```bash
   # Before reboot
   ~/.config/i3/scripts/save-workspaces.sh
   systemctl reboot

   # Before shutdown
   ~/.config/i3/scripts/save-workspaces.sh
   systemctl poweroff

   # Before logout
   ~/.config/i3/scripts/save-workspaces.sh
   i3-msg exit
   ```

6. **Reload i3:**

   ```bash
   i3-msg reload
   ```

## Usage

### Automatic Operation

Once configured:

- **On startup:** Workspaces are automatically restored
- **On shutdown/reboot/logout:** Workspaces are automatically saved (if integrated with power menu)

### Manual Operation

**Save all workspaces:**

```bash
~/.config/i3/scripts/save-workspaces.sh
```

**Restore all workspaces:**

```bash
~/.config/i3/scripts/restore-workspaces.sh
```

**Rofi menus** (if keybinding configured):

Press `$mod+Shift+r` to open the rofi menu for manual save/restore/delete operations.

### 🎯 Rofi Menu Scripts

Two rofi scripts are included for manual workspace management:

#### `i3-resurrect-rofi.sh` (Full Menu)

This is the recommended script with additional bulk operations:

| Action | Description |
|--------|-------------|
| **Save All** | Saves all workspaces defined in `config.sh` |
| **Restore All** | Restores all workspaces defined in `config.sh` |
| **Save** | Save a single profile (layout + programs) |
| **Restore** | Restore a single profile |
| **Delete** | Delete a saved profile |

After selecting Save/Restore/Delete, you'll be prompted to:
1. Choose a profile name
2. Choose a target: Both, Programs only, or Layout only

#### `i3-resurrect-rofi-simple.sh` (Simple Menu)

A lightweight alternative without bulk operations:

| Action | Description |
|--------|-------------|
| **Save** | Save a single profile |
| **Restore** | Restore a single profile |
| **Delete** | Delete a saved profile |

**Workflow:**
1. Select action → Save / Restore / Delete
2. Select profile → Lists existing profiles
3. Select target → Both / Programs / Layout

### Saved Files Location

Profiles are saved to `~/.i3/i3-resurrect/profiles/`:

```
~/.i3/i3-resurrect/profiles/
├── Workspace1_layout.json
├── Workspace1_programs.json
├── Workspace2_layout.json
├── Workspace2_programs.json
└── ...
```

## Configuration

### Workspace Mapping

Edit `~/.config/i3/scripts/config.sh`:

```bash
declare -A workspace_map=(
    ["1"]="Workspace1"      # Workspace 1 saves to profile "Workspace1"
    ["2"]="Workspace2"      # Workspace 2 saves to profile "Workspace2"
    # Add more mappings as needed
)
```

### Swallow Criteria

The save script uses `--swallow=class,instance,title` by default. You can modify this in `save-workspaces.sh` if needed. Options are:

- `class` - Window class
- `instance` - Window instance
- `title` - Window title
- `window_role` - Window role

### Restore Delay

The restore script has a 2-second delay by default to allow i3 to fully initialise. Adjust the `sleep 2` value in `restore-workspaces.sh` if needed.

## Troubleshooting

### Workspaces not saving

1. Check your workspace names match i3's actual workspace identifiers:

   ```bash
   i3-msg -t get_workspaces | jq '.[].name'
   ```

2. Ensure the workspace mapping in `config.sh` uses the correct workspace names/numbers.

### Applications not restoring correctly

1. Some applications may need custom swallow criteria. Check the `*_layout.json` files and adjust swallow rules as needed.

2. Run restore manually with debug output:

   ```bash
   i3-resurrect restore -w 1 -p Workspace1
   ```

### Layout files are empty

This usually means the workspace name doesn't match what i3 reports. Verify with:

```bash
i3-msg -t get_workspaces | jq '.[].name'
```

## File Structure

```
i3-resurrect-auto/
├── README.md
├── LICENSE
├── install.sh
└── scripts/
    ├── config.sh              # Workspace mapping configuration
    ├── save-workspaces.sh     # Save all workspaces
    ├── restore-workspaces.sh  # Restore all workspaces
    └── i3-resurrect-rofi.sh   # Rofi menu for manual operations
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [i3-resurrect](https://github.com/JonnyHaystack/i3-resurrect) by JonnyHaystack
- [i3wm](https://i3wm.org/)
- [rofi](https://github.com/davatorium/rofi)

---

Made with ❤️ using Linux and Vim
