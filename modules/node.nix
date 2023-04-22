# Non-declarative Node.js Environment.
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

  config = { mz.home.packages = with pkgs; [ nodejs-16_x ]; };
}
