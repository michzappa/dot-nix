{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.protonmail;
in {
  options.mz.protonmail = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    mz.home = {
      packages = with pkgs; [ protonmail-bridge ];
      programs.fish.functions = {
        protonmail-bridge-restart =
          "systemctl restart --user protonmail-bridge.service";
      };
      systemd.user.services.protonmail-bridge = {
        Install.WantedBy = [ "default.target" ];
        Service = {
          Environment = "PATH=${pkgs.gnome.gnome-keyring}/bin";
          ExecStart =
            "${pkgs.protonmail-bridge}/bin/protonmail-bridge --no-window --log-level debug";
        };
        Unit = {
          After = [ "network.target" ];
          Description = "ProtonMail Bridge";
        };
      };
    };
  };
}
