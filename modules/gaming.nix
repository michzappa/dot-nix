# Configuration For Gaming On NixOS
{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.gaming;
in {
  options.mz.gaming = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable (ifNixOS {
    # Steam is installed with Flatpak.
    hardware.opengl.driSupport32Bit = true;
    mz.user.packages = with pkgs; [
      samba
      wineWowPackages.staging
      prismlauncher
    ];
    # For LAN-like Minecraft servers.
    services.zerotierone.enable = true;
  });
}
