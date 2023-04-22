{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.android;
in {
  options.mz.android = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };

    waydroid = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable (ifNixOS {
    mz.user = {
      extraGroups = [ "adbusers" ];
      packages = with pkgs; [ android-studio ];
    };

    programs.adb.enable = true;

    services.udev.packages = [ pkgs.android-udev-rules ];

    virtualisation = mkIf cfg.waydroid {
      lxd.enable = true;
      waydroid.enable = true;
    };
  });
}
