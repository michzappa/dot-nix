{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.gnupg;
in {
  options.mz.gnupg = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable (ifNixOS {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  });
}
