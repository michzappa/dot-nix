{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.mullvad;
in {
  options.mz.mullvad = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable (ifNixOS {
    environment.systemPackages = with pkgs; [ mullvad-vpn ];

    services.mullvad-vpn.enable = true;
  });
}
