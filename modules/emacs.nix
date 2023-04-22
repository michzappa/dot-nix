# Emacs Installation and Integration.
{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.emacs;
in {
  options.mz.emacs = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    mz.home = {
      programs = {
        emacs = {
          enable = true;
          extraPackages = (epkgs: (with epkgs; [ pdf-tools vterm ]));
          package = pkgs.emacsGit;
        };
        fish.functions = { ec = "emacsclient -t -a '' $argv"; };
      };
    };
  };
}
