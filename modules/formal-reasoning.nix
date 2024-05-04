{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.formal-reasoning;
in {
  options.mz.formal-reasoning = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    mz.home = {
      file.".agda/defaults".text = "standard-library";
      packages = with pkgs; [
        (agda.withPackages [ agdaPackages.standard-library ])
        coq
        lean4
      ];
      programs.emacs.extraPackages =
        (epkgs: (with epkgs; [ agda2-mode proof-general ]));
    };
  };
}
