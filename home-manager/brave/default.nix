{ config, pkgs, ... }:

{
  programs.brave = {
    enable = true;
    commandLineArgs = [
      "--enable-wayland-ime"
      "--ozone-platform=wayland"
      "--enable-features=UseOzonePlatform"    
    ];
  };
}
