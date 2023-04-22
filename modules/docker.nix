# Docker Setup.
{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.docker;
in {
  options.mz.docker = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable (ifNixOS {
    mz.user.extraGroups = [ "docker" ];

    virtualisation.docker.enable = true;
  });
}
