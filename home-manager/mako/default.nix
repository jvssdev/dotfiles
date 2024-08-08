{ pkgs, lib, config, ... }:

{
  services.mako = {
    enable = true;
    icons = true;
    defaultTimeout = 10000; # 10 secs
    extraConfig = ''
        [mode=do-not-disturb]
        invisible=1
    '';
  };
}
