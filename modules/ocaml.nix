# OCaml development environment.

{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.ocaml;
in {
  options.mz.ocaml = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = {
    mz.home = {
      packages = with pkgs; [ opam ];
      programs = {
        fish.shellInit = mkIf config.mz.fish.enable ''
          source ${config.mz.user.homeDir}/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
        '';
      };
    };
  };
}
