
{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "jvssdev";
    userEmail = "joaovic0410@hotmail.com";
  };
}
