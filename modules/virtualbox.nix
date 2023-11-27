{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.virtualbox;
in {
  options.mz.virtualbox = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    users.extraGroups.vboxusers.members = [ config.mz.user.name ];
    virtualisation.virtualbox = {
      guest.enable = true;
      guest.x11 = true;
      host.enable = true;
    };
  };
}
