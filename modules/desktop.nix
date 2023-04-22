# "Linux on the Deskop" Configuration
{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.desktop;
in {
  options.mz.desktop = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable (mkMerge [
    { mz = { user.extraGroups = [ "networkmanager" "uinput" ]; }; }

    (ifNixOS {
      environment = {
        variables = { TERM_APP = "xfce4-terminal"; };
        systemPackages = with pkgs; [
          autorandr
          pavucontrol
          xfce.xfce4-panel
          xfce.xfce4-pulseaudio-plugin
        ];
      };

      fonts = {
        fonts = with pkgs; [
          noto-fonts
          noto-fonts-cjk
          noto-fonts-emoji
          noto-fonts-extra
        ];
      };

      i18n = {
        inputMethod = {
          enabled = "ibus";
          ibus.engines = with pkgs.ibus-engines; [ anthy libpinyin rime ];
        };
      };

      programs.thunar = {
        enable = true;
        plugins = with pkgs.xfce; [ thunar-archive-plugin ];
      };

      xdg.portal.enable = true;
      services = {
        autorandr.enable = true;
        blueman.enable = true;
        xserver = {
          enable = true;
          desktopManager.gnome.enable = true;
          displayManager.gdm.enable = false;
          desktopManager.xfce = {
            enable = true;
            noDesktop = true;
            enableXfwm = false;
          };
          displayManager.defaultSession = "xfce+i3";
          windowManager.i3.enable = true;
          libinput.enable = true;
        };
        pipewire = {
          enable = true;
          alsa = {
            enable = true;
            support32Bit = true;
          };
          pulse.enable = true;
        };
      };

      hardware.pulseaudio.enable = false;

      security.rtkit.enable = true;

      sound.enable = false;
    })
  ]);
}
