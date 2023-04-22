# Git Configuration.
{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.git;
in {
  options.mz.git = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };

    name = mkOption {
      type = types.str;
      default = "Michael Zappa";
    };

    email = mkOption {
      type = types.str;
      default = "me@michzappa.com";
    };

    forgeAccount = mkOption {
      type = types.str;
      default = "michzappa";
    };
  };

  config = mkIf cfg.enable {
    mz.home = {
      programs.git = {
        enable = true;
        userName = cfg.name;
        userEmail = cfg.email;
        extraConfig = {
          gitlab.user = cfg.forgeAccount;
          github.user = cfg.forgeAccount;
        };
      };
    };
  };
}
