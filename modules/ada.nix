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
        # Newer package definitions do not build.
        inputs.nixpkgs-old.legacyPackages.${pkgs.system}.emacsPackages.ada-mode

        alire
        gprbuild
      ];
    };
  };
}
