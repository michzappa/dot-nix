# Ada development environment.

{ config, inputs, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.ada;
in {
  options.mz.ada = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = {
    mz.home = {
      packages = with pkgs; [
        gprbuild

        old.emacsPackages.ada-mode

        unstable.alire
      ];
    };
  };
}
