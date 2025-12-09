#!/bin/bash

set +e

export XDG_CURRENT_DESKTOP=wlroots

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots >/dev/null 2>&1

# swaync -c ~/.config/mango/swaync/config.jsonc -s ~/.config/mango/swaync/style.css >/dev/null 2>&1 &

wlsunset -T 3501 -t 3500 >/dev/null 2>&1 &

wpaperd -d &

waybar -c ~/.config/mango/waybar/config.jsonc -s ~/.config/mango/waybar/style.css >/dev/null 2>&1 &

wl-paste --type text --watch cliphist store >/dev/null 2>&1 &

wl-paste --type image --watch cliphist store >/dev/null 2>&1 &

blueman-applet >/dev/null 2>&1 &

nm-applet >/dev/null 2>&1 &

/usr/lib/xfce-polkit/xfce-polkit >/dev/null 2>&1 &
