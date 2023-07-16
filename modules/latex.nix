# Latex environment.

{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.latex;
in {
  options.mz.latex = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = {
    mz.home = {
      packages = with pkgs; [ texlive.combined.scheme-full ];
      programs.emacs.extraPackages = (epkgs: (with epkgs; [ auctex ]));
    };
  };
}
