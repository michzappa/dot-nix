{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.bitwarden;
in {
  options.mz.bitwarden = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    mz.home = {
      packages = with pkgs; [ bitwarden bitwarden-cli ];
      programs.fish.functions = {
        bwu = ''export BW_SESSION="$(bw unlock --raw)"'';
        bwl = "export BW_SESSION=";
      };
    };
  };
}
