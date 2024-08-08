{ config, lib, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      # font
      font_family = "JetBrainsMono Nerd Font";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = 12;
      hide_window_decorations = true;

      # pages
      "ctrl+shift+up" = "scroll_line_up";
      "ctrl+shift+down" = "scroll_line_down";
      "ctrl+shift+k" = "scroll_line_up";
      "ctrl+shift+j" = "scroll_line_down";

      # cursor
      cursor_shape = "block";

      scrollback_lines = 2000;

      # border
      window_padding_width = 0;

      background = "#24283b";  
      foreground = "#a9b1d6";  
      section_background = "#24283b";
      section_foreground = "#a9b1d6";
      url_color = "#9ece6a";   
      cursor = "#c0caf5";
      active_border_color = "#3d59a1";  
      inactive_border_color = "#101014"; 
      active_tab_background = "#16161e";
      active_tab_foreground = "#3d59a1";
      inactive_tab_background = "#16161e";
      inactive_tab_foreground = "#787c99";
      tab_bar_background = "#101014";

      # normal colors
      color0 = "#414868";  
      color1 = "#f7768e";  
      color2 = "#73daca";  
      color3 = "#e0af68";  
      color4 = "#7aa2f7";  
      color5 = "#bb9af7";  
      color6 = "#7dcfff";  
      color7 = "#c0caf5";  

      # bright colors
      color8 = "#414868";  
      color9 = "#f7768e";  
      color10 = "#73daca";  
      color11 = "#e0af68";  
      color12 = "#7aa2f7";  
      color13 = "#bb9af7";  
      color14 = "#7dcfff";  
      color15 = "#c0caf5";  

      # extended colors
      color16 = "#e06c75";  
      color17 = "#be5046";  
      color18 = "#2e3440";  
      color19 = "#3b4252";  
      color20 = "#a3be8c";  
      color21 = "#b48ead";  

      # additional settings
      cursor_text_color = "#1a1b26";
      selection_foreground = "none";
      selection_background = "#28344a";
      tab_bar_style = "fade";
      tab_fade = 1;
      active_tab_font_style = "bold";
      inactive_tab_font_style = "bold";
      macos_titlebar_color = "#16161e";
    };
  };
}

