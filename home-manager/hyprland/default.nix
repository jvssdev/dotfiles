{ config, inputs, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;

    extraConfig = ''
      monitor=,highres, auto, 1.25
      env = PATH,$PATH:$scrPath
      env = XDG_CURRENT_DESKTOP,Hyprland
      env = XDG_SESSION_TYPE,wayland
      env = XDG_SESSION_DESKTOP,Hyprland
      env = QT_QPA_PLATFORM,wayland;xcb
      env = QT_QPA_PLATFORMTHEME,qt6ct
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
      env = QT_AUTO_SCREEN_SCALE_FACTOR,1
      env = MOZ_ENABLE_WAYLAND,1
      env = GDK_SCALE,1
      # Execute your favorite apps at launch
      exec-once = swww init
      exec-once = nm-applet --indicator
      exec-once = waybar
      exec-once = wl-paste --type text --watch cliphist store
      exec-once = wl-paste --type image --watch cliphist store
      exec-once = blueman-applet
      exec-once = systemctl
      exec-once = mako
      exec-once = hypridle
      # Some default env vars.
      env = XCURSOR_SIZE,24

      input {
          kb_layout = us
          follow_mouse = 1
          kb_variant = alt-intl

          touchpad {
              natural_scroll = no
          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      general {
          gaps_in = 0
          gaps_out = 0
          border_size = 2
          #col.active_border = rgba(7aa2f7aa)
          #col.inactive_border = 0x00000000;
          resize_on_border = yes
          extend_border_grab_area = 15
          layout = dwindle
      }

      decoration {
          rounding = 6
          #blur {
           # enabled = true
            #size = 3
            #new_optimizations = true
            #passes = 1
          #}
      }

      animations {
          enabled = yes
          bezier = wind, 0.05, 0.9, 0.1, 1.05
          bezier = winIn, 0.1, 1.1, 0.1, 1.1
          bezier = winOut, 0.3, -0.3, 0, 1
          bezier = liner, 1, 1, 1, 1
          animation = windows, 1, 3, wind, slide
          animation = windowsIn, 1, 3, winIn, slide
          animation = windowsOut, 1, 3, winOut, slide
          animation = windowsMove, 1, 3, wind, slide
          animation = fade, 1, 5, default
          animation = workspaces, 1, 3, wind
      }

      dwindle {
          pseudotile = yes
          preserve_split = yes
      }

      master {
          new_status = master
      }

      gestures {
          workspace_swipe = off
      }

      device {
        name = epic mouse V1
        sensitivity = -0.5
      }

      # See https://wiki.hyprland.org/Configuring/Window-Rules/

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER

      bindl = ,switch:Lid Switch, exec, swaylock

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod, T, exec, kitty
      bind = $mainMod, Delete, exit,
      bind = $mainMod, W, togglefloating,
      bind = $mainMod, Q, killactive
      bind = $mainMod, F, exec, firefox
      bind = $mainMod, A, exec, fuzzel
      bind = $mainMod, J, togglesplit, # dwindle
      bind = $mainMod, Backspace, exec, wlogout
      bind = $mainMod SHIFT, S, exec, grimblast copy area
      bind = $mainMod, V, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy


      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d
      bind = Alt, Tab, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Move focused window around the current workspace
      bind = $mainMod+Shift+Ctrl, Left, movewindow, l
      bind = $mainMod+Shift+Ctrl, Right, movewindow, r
      bind = $mainMod+Shift+Ctrl, Up, movewindow, u
      bind = $mainMod+Shift+Ctrl, Down, movewindow, d

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      #windowrulev2 = opacity 0.80 0.80,class:^(kitty)$
      #windowrulev2 = opacity 0.90 0.90,class:^(firefox)$
      #windowrulev2 = opacity 0.90 0.90,class:^(librewolf)$
      #windowrulev2 = opacity 0.90 0.90,class:^(wezterm)$

      misc {
        vrr = 0
        disable_hyprland_logo = true
        disable_splash_rendering = true
        force_default_wallpaper = 0
      }
    '';
  };
}
