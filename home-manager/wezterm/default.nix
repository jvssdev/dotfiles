{ pkgs, ... }:
let
  zsh_path_lua_str = "'${pkgs.zsh}/bin/zsh'";
in
{
  home = {
    sessionVariables = { TERM = "wezterm"; };
  };

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;

    extraConfig = ''
      local wezterm = require('wezterm')
      local config = wezterm.config_builder()
      config.hide_mouse_cursor_when_typing = false
      config.window_decorations = 'RESIZE'
      
      local function format_tab_title(tab, idx, max_width, is_mux_win)
        return string.format(' %d %s ', idx, wezterm.truncate_left(tab_title(tab, is_mux_win), max_width - 6))
      end

      local function active_tab_idx(tabs)
        for _, tab in ipairs(tabs) do
          if tab.is_active then
            return tab.tab_index
          end
        end
        return -1
      end
      
      wezterm.on('update-status', function(window)
        local mux_win = window:mux_window()
        local total_width = mux_win:active_tab():get_size().cols
        local all_tabs = mux_win:tabs()
        local tabs_max_width = config.tab_max_width * #all_tabs
        local tabs_total_width = 0
        for _, tab in ipairs(mux_win:tabs()) do
          tabs_total_width = tabs_total_width + #format_tab_title(tab, 0, tab_max_width, true) + 6
        end
        window:set_left_status(string.rep(' ', (total_width / 2) - (tabs_total_width / 2)))
      end)

      wezterm.on('format-tab-title', function(tab, tabs)
        local i = tab.tab_index
        local title = format_tab_title(tab, i + 1, tab_max_width)

        local bar_bg = '#292e42'
        local inactive_bg = '#585b70'
        local active_bg = '#1e1e2e'
        local bg = inactive_bg
        local fg = '#cdd6f4'
        if tab.is_active then
          bg = active_bg
        end

        local active_idx = active_tab_idx(tabs)
        local end_sep_color = bar_bg
        if i == (active_idx - 1) then
          end_sep_color = active_bg
        end

        return {
          { Background = { Color = bar_bg } },
          { Foreground = { Color = bg } },
          { Text = "▐" },
          { Background = { Color = bg } },
          { Foreground = { Color = fg } },
          { Text = title },
          { Text = has_unseen_output and '  ' or "" },
          { Background = { Color = bar_bg } },
          { Foreground = { Color = bg } },
          { Text = "▌" },
          { Background = { Color = bar_bg } },
          { Foreground = { Color = bar_bg } },
        }
      end)

      config.color_scheme = 'tokyonight_night'
      config.colors = {
        tab_bar = {
          background = '#292e42'
        }
      }
      config.font = wezterm.font({
        family = 'JetBrains Mono',
        harfbuzz_features = {
          'cv03',
          'cv04',
          'ss01',
          'ss02',
          'ss03',
          'ss04',
          'ss05',
        },
      })
      config.font_size = 16

      config.window_padding = {
        top = 0,
        bottom = 0,
        left = 0,
        right = 0,
      }
      config.debug_key_events = false
      config.inactive_pane_hsb = {
        saturation = 0.7,
        brightness = 0.6,
      }
      config.front_end = 'WebGpu'
      config.webgpu_power_preference = 'HighPerformance'

      config.keys = {
        { key = '-', mods = 'SUPER', action = wezterm.action.DecreaseFontSize },
        { key = '0', mods = 'SUPER', action = wezterm.action.ResetFontSize },
        { key = '=', mods = 'SUPER', action = wezterm.action.IncreaseFontSize },
        { key = 'p', mods = 'SUPER', action = wezterm.action.ActivateCommandPalette },
      }
      config.enable_tab_bar = false
      config.use_fancy_tab_bar = false

      -- Configuração do cursor
      config.cursor_thickness = 2  -- Define a espessura do cursor
      config.cursor_blink_rate = 500  -- Define a taxa de piscar do cursor em milissegundos

      return config
    '';
  };
}

