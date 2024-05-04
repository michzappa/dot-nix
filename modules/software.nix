{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.software;
in {
  options.mz.software = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };

    gui-apps = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      mz.home.packages = with pkgs; [
        gnumake
        ispell
        knock
        qemu
        ripgrep
        screen
        tree
        unzip
        wget
        zip
      ];
    }

    (ifNixOS {
      environment.systemPackages = with pkgs; [ emacs gcc ];

      environment.variables.LD_LIBRARY_PATH =
        pkgs.lib.makeLibraryPath [ pkgs.libuuid ];

      mz.user.packages = with pkgs;
        mkIf cfg.gui-apps [
          calibre
          chromium
          gramps
          ghidra
          gthumb
          ledger
          libreoffice
          thunderbird
          vorta
          xournalpp
          zoom-us
        ];

      # Install apps
      services.flatpak.enable = true;

      # Imperfect solution for having system fonts in Flatpaks:
      # - cp -R -L /run/current-system/sw/share/X11/fonts ~/.local/share/fonts
      fonts.fontDir.enable = true;
    })
  ]);
}
