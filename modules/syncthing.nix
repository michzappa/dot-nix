# Installation of Syncthing
{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.syncthing;
in {
  options.mz.syncthing = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable (ifNixOS {
    services.syncthing = {
      enable = true;
      user = config.mz.user.name;
      group = "users";
      dataDir = "/home/${config.mz.user.name}";
      configDir = "/home/${config.mz.user.name}/.config/syncthing";
      openDefaultPorts = true;
    };
  });
}
