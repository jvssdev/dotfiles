{ config, lib, namespace, ... }:
{
  services.cliphist = {
      enable = true;
      allowImages = true;
  };
}

