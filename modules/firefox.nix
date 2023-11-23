# Firefox Installation and Configuration.
{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.firefox;
in {
  options.mz.firefox = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    mz.home = {
      programs.firefox = {
        enable = true;
        package = pkgs.firefox-wayland;
        profiles.default = {
          id = 0;
          isDefault = true;
          settings = {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.tabs.loadDivertedInBackground" = true;
          };
        };
      };
    };
  };
}
