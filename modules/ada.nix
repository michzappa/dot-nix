# Ada development environment.

{ config, lib, options, pkgs, ... }:
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
      packages = with pkgs; [ alire gprbuild ];
      # programs.emacs.extraPackages = (epkgs: (with epkgs; [ ada-mode ])); XXX: Does not build.
    };
  };
}
