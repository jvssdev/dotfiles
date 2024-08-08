{ config, pkgs, lib, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin-top = 0;
        margin-left = 0;
        margin-right = 0;
        height = 20;
        spacing = 0;

        modules-left = [
          "custom/menu"
          "custom/separator#blank_2"
          "hyprland/workspaces"
          "custom/separator#blank_2"
          "custom/music"
          "custom/separator#blank_2"
          "custom/notifications"
          "custom/separator#blank_2"
          "tray"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "group/motherboard"
          "custom/separator#blank_2"
          "group/laptop"
          "custom/separator#blank_2"
          "group/audio"
          "custom/separator#blank_2"
          "custom/power"
        ];

        "custom/menu" = {
            "format" = ""; 
            "exec" = "echo ; echo 󱓟 app launcher";
            "interval" = 86400;
            "tooltip" = true;
            "on-click" = "pkill fuzzel || fuzzel";
        };
        "custom/music" = {
            "format" =  "󰎆  {}";
            "escape" = true;
            "interval" = 5;
            "tooltip" = false;
            "exec" = "playerctl metadata --format='{{ title }}'";
            "on-click" = "playerctl play-pause";
            "max-length" = 40;
          };

        "custom/notifications" = {
            tooltip = false;
            format = "{icon}";
            format-icons = {
              notification = "<span foreground='red'><sup></sup></span>";
              none = "";
              dnd-notification = "<span foreground='red'><sup></sup></span>";
              dnd-none = "";
              inhibited-notification = "<span foreground='red'><sup></sup></span>";
              inhibited-none = "";
              dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
              dnd-inhibited-none = "";
            };
            return-type = "json";
            exec = "bash -c 'makoctl list | grep -q \"^\" && echo \"{\"icon\": \"󰂛\"}\" || echo \"{\"icon\": \"\"}\"'";
            on-click = "makoctl dismiss";
            on-click-right = "makoctl dismiss -a";
            escape = true;
        };

        "group/motherboard" = {
          orientation = "horizontal";
          modules = [ "cpu" "memory" ];
        };

        "group/laptop" = {
          orientation = "horizontal";
          modules = [ "backlight" "battery"];
        };

        "group/audio" = {
          orientation = "horizontal";
          modules = [ "pulseaudio" ];
        };

        backlight = {
          device = "intel_backlight";
          format = "{icon} {percent}%";
          interval = 2;
          align = 0;
          rotate = 0;
          format-icons = [ "" "" "" "" "" "" "" "" "" ];
          icon-size = 10;
          on-scroll-up = "brightnessctl set 1%+";
          on-scroll-down = "brightnessctl set 1%-";
          min-length = 6;
        };

        battery = {
          format = "{icon} {capacity}%";
          format-icons = {
            charging = [ "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅" ];
            default = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          };
          interval = 5;
          states = { warning = 25; critical = 10; };
          tooltip = false;
        };

        bluetooth = {
          format = "";
          format-disabled = "󰂳";
          format-connected = "󰂱 {device_alias}";
          tooltip-format = " {device_alias}";
          tooltip-format-connected = "{device_enumerate}";
          format-connected-battery = "󰂱 {device_alias} (󰥉 {device_battery_percentage}%)";
          tooltip-format-enumerate-connected = " {device_alias} 󰂄{device_battery_percentage}%";
          tooltip = true;
          on-click = "${lib.getExe' pkgs.blueberry "blueberry"}";

        };

        clock = {
          interval = 1;
          format = " {:%H:%M:%S}";
          format-alt = " {:%H:%M   %Y, %d %B, %A}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode"; 
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        cpu = {
          interval = 5;
          format = "  {}% ";
          max-length = 10;
        };

        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          format-icons = {
            active = "";
            default = "";
          };
          persistent_workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
            "6" = [];
            "7" = [];
            "8" = [];
            "9" = [];
            "10" = [];
          };
        };

        memory = {
          interval = 5;
          format = "  {}% ";
          max-length = 10;
        };

        tray = {
          icon-size = 15;
          spacing = 8;
        };

        network = {
          format-wifi = "{icon} {essid}";
          format-disconnected = "Disconnected ⚠ ";
          format-icons = [ "󰤯 " "󰤟 " "󰤢 " "󰤥 " "󰤨 " ];
          tooltip-format-disconnected = "Disconnected";
          tooltip-format-wifi = "{icon} {essid}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
          format-ethernet = "{ifname}";
          tooltip-format-ethernet = "󰀂  {ifname}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          nospacing = 1;
          interval = 5;
        };

        pulseaudio = {
          format = "{icon}{volume}%";
          format-bluetooth = "󰂰 {volume}%";
          nospacing = 1;
          tooltip-format = "Volume : {volume}%";
          format-muted = "󰝟 ";
          format-icons = {
            headphone = " ";
            default = [ "󰕿 " "󰖀 " "󰕾 " ];
          };
          on-click = "pavucontrol";
          scroll-step = 1;
        };

        "custom/power" = {
          format = "⏻ ";
          tooltip = false;
          on-click = "wlogout &";
        };

        mpd = {
          format = "{stateIcon} {title}";
          format-disconnected = " Disconnected";
          format-stopped = " Stopped";
          unknown-tag = "N/A";
          interval = 2;
          state-icons = {
            paused = "";
            playing = "";
          };
          on-click = "mpd toggle";
          tooltip-format = "MPD (connected)";
          tooltip-format-disconnected = "MPD (disconnected)";
        };

        "custom/separator#blank_2" = {
          format = "  ";
          interval = "once";
          tooltip = false;
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-weight: bold;
        min-height: 0;
        font-size: 97%;
        font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
        padding: 1px;
      }

      @define-color base   #1e1e2e;
      @define-color mantle #181825;
      @define-color crust  #11111b;
      @define-color text     #cdd6f4;
      @define-color subtext0 #a6adc8;
      @define-color subtext1 #bac2de;
      @define-color surface0 #313244;
      @define-color surface1 #45475a;
      @define-color surface2 #585b70;
      @define-color overlay0 #6c7086;
      @define-color overlay1 #7f849c;
      @define-color overlay2 #9399b2;
      @define-color theme_text_color #acb0d0;
      @define-color theme_base_color #1a1b26;
      @define-color blue      #7aa2f7; 
      @define-color lavender  #b4befe;
      @define-color sapphire  #74c7ec;
      @define-color sky       #89dceb;
      @define-color teal      #1abc9c;
      @define-color green     #9ece6a;
      @define-color yellow    #e0af68;
      @define-color peach     #fab387;
      @define-color maroon    #eba0ac;
      @define-color red       #f7768e;
      @define-color mauve     #c678dd;
      @define-color pink      #f4b8e4;
      @define-color flamingo  #f2cdcd;

      window#waybar {
        background: #000000;
        border-radius: 0px;
        border: 2px solid #000000;
      }
      
      #custom-separator_blank_2, #separator, #spacer {
        background:  #000000;
        padding: 3px;
      }

      #custom-menu {
        padding-left: 6px;
      }

      #backlight {
        background: #000000;
      }

      #battery {
        background: #000000;
      }

      #bluetooth {
        background: #000000;
      }

      #clock {
        background: #000000;
        color: @text;
        padding: 3px;
        border-radius: 10px;
      }

      #cpu {
        background: #000000;
      }

      #hyprland-workspaces {
        background: #000000;
      }

      #memory {
        background:#000000;
      }

      #tray {
        background: #000000;
      }

      #network {
        background: #000000;
      }

      #pulseaudio {
        background: #000000;
      }

      #custom-power {
        background: #000000;
      }

      #mpd {
        background: #000000;
      }

      #custom-music {
        background: #000000;
      }

      #custom-notification {
        padding: 0 10px;
        background-color: #000000;
      }

      .tooltip {
        font-size: 97%;
        padding: 2px;
      }
    '';
  };
}

