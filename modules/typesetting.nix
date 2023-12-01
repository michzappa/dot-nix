{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.typesetting;
in {
  options.mz.typesetting = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = {
    mz.home = {
      packages = with pkgs; [ texlive.combined.scheme-full typst ];
      # Note: typst-ts-mode, is not yet in Nixpkgs - relatively
      # straightforward to install manually (with
      # treesit-install-language-grammar in Emacs).
      programs.emacs.extraPackages = (epkgs: (with epkgs; [ auctex ]));
    };
  };
}
