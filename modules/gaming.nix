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
    hardware.opengl.driSupport32Bit = true;

    mz.user.packages = with pkgs; [
      heroic
      prismlauncher
      samba
      wineWowPackages.staging
      steam
    ];

    # For LAN-like Minecraft servers.
    services.zerotierone.enable = true;
  });
}
