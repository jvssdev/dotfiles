| **OS**                                      | NixOS           |
|---------------------------------------------|-----------------|
| **Window Manager**                          | Hyprland        |
| **Bar**                                     | Waybar          |
| **Terminal**                                | Kitty & Tmux    |
| **Shell**                                   | Zsh             |
| **Text Editor**                             | Neovim          |
| **Color Scheme, font and wallpaper setter** | Stylix          |
| **Network Manager**                         | NetworkManager  |
| **Notification Daemon**                     | Mako            |

- If you want to use NixOS: add stuff you currently have on `/etc/nixos/` to
  `nixos` (usually `configuration.nix` and `hardware-configuration.nix`, when
  you're starting out).
    - The included file has some options you might want, specially if you don't
      have a configuration ready. Make sure you have generated your own
      `hardware-configuration.nix`; if not, just mount your partitions to
      `/mnt` and run: `nixos-generate-config --root /mnt`.
- If you want to use home-manager: add your stuff from `~/.config/nixpkgs`
  to `home-manager` (probably `home.nix`).

- Run `sudo nixos-rebuild switch --flake .#hostname` to apply your system
  configuration.
    - If you're still on a live installation medium, run `nixos-install --flake
      .#hostname` instead, and reboot.
- Run `home-manager switch --flake .#username@hostname` to apply your home
  configuration.
  - If you don't have home-manager installed, try `nix shell nixpkgs#home-manager`.
