# Nix Configuration

Cross-platform declarative system and user configuration for:
- **Garuda Linux** (Arch-based) on Main PC (`shivraj@garuda`)
- **macOS** (Apple Silicon) on Work Laptop (`shivraj@work-mac`)

---

## Structure

```text
.
├── flake.nix              # Entry point defining Nix configurations
├── modules/
│   ├── common.nix         # Shared cross-platform CLI & GUI packages
│   └── claude.nix         # Claude Code CLI configuration
├── hosts/
│   ├── garuda/
│   │   └── home.nix       # Linux Home Manager configuration
│   └── macos/
│       ├── darwin.nix     # nix-darwin system module
│       └── home.nix       # macOS Home Manager configuration
├── config/                # Direct live config directories (hypr, nvim, ghostty, etc.)
└── home_files/            # Dotfiles linked to ~ (.zshrc, .p10k.zsh, .gitconfig, etc.)
```

---

## Usage

Use the unified OS-aware shortcut in your shell:

```bash
hms
```

Or run manually:

* **Linux (Garuda):**
  ```bash
  home-manager switch --flake "$HOME/.config/nix-config#shivraj@garuda"
  ```
* **macOS:**
  ```bash
  sudo darwin-rebuild switch --flake "$HOME/.config/nix-config#shivraj@work-mac"
  ```

---

## Non-NixOS Linux Setup (Important)

When bootstrapping this configuration on a non-NixOS Linux distribution (like Arch / Garuda), Home Manager manages desktop integration and GPU driver access via `targets.genericLinux`.

### 1. GPU Acceleration Setup (One-Time Setup)
Nix GUI applications (e.g., Ghostty, WezTerm, Obsidian) look for OpenGL and Vulkan drivers in `/run/opengl-driver/lib`.

To link your host graphics drivers (NVIDIA / AMD / Intel) to this path:

1. Run `hms` (or `home-manager switch`). Home Manager will output the path to the `non-nixos-gpu-setup` script.
2. Run the generated script with `sudo`:
   ```bash
   sudo /nix/store/*non-nixos-gpu*/bin/non-nixos-gpu-setup
   ```

**What this does:**
- Creates `/run/opengl-driver` pointing to host GPU libraries.
- Installs `/etc/tmpfiles.d/non-nixos-gpu.conf` so the link automatically persists across reboots.
- Allows all Nix GUI applications to use hardware GPU acceleration natively with zero custom wrappers.
