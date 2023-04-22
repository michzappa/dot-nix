# Direnv Integration
{ config, inputs, lib, options, pkgs, platform, ... }:
with lib;
with lib.mz;
let cfg = config.mz.direnv;
in {
  options.mz.direnv = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    mz.home = {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}
