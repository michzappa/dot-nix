{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.java;
in {
  options.mz.java = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable (ifNixOS {
    mz.home.packages = with pkgs; [ jetbrains.idea-community ];

    programs.java = {
      enable = true;
      package = pkgs.openjdk11;
    };
  });
}
