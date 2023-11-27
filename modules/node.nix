{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.nodejs;
in {
  options.mz.nodejs = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  # This does not attempt to be declarative given the nature of node
  # projects. Everything is installed via NPM or other package
  # manager.
  config = { mz.home.packages = with pkgs; [ nodejs_18 ]; };
}
