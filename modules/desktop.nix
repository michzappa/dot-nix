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
    {
      mz = {
        home.dconf.settings = with lib.hm.gvariant;
          (mkMerge [
            (ifNixOS {
              "org/gnome/desktop/background" = {
                picture-uri =
                  "file:///run/current-system/sw/share/backgrounds/gnome/adwaita-l.jpg";
                picture-uri-dark =
                  "file:///run/current-system/sw/share/backgrounds/gnome/adwaita-d.jpg";
              };

              "org/gnome/desktop/screensaver" = {
                picture-uri =
                  "file:///run/current-system/sw/share/backgrounds/gnome/adwaita-l.jpg";
                picture-uri-dark =
                  "file:///run/current-system/sw/share/backgrounds/gnome/adwaita-d.jpg";
              };
            })

            (ifHomeManager {
              "org/gnome/desktop/input-sources" = {
                xkb-options = [ "terminate:ctrl_alt_bksp" "ctrl:nocaps" ];
              };
            })

            {
              "org/freedesktop/ibus/engine/anthy/common" = {
                conversion-segment-mode = 0;
                input-mode = 0;
                show-dict-mode = false;
                show-typing-method = true;
                typing-method = 0;
              };

              "org/gnome/desktop/background" = {
                color-shading-type = "solid";
                picture-options = "zoom";
                primary-color = "#3071AE";
                secondary-color = "#000000";
              };

              "org/gnome/desktop/input-sources" = {
                per-window = false;
                sources = [
                  (mkTuple [ "xkb" "us" ])
                  (mkTuple [ "xkb" "fr+us" ])
                  (mkTuple [ "xkb" "it+us" ])
                  (mkTuple [ "xkb" "ie" ])
                  (mkTuple [ "ibus" "rime" ])
                  (mkTuple [ "ibus" "anthy" ])
                ];
                xkb-options = [ "terminate:ctrl_alt_bksp" ];
              };

              "org/gnome/desktop/interface" = {
                clock-format = "12h";
                color-scheme = "prefer-dark";
                font-antialiasing = "grayscale";
                font-hinting = "slight";
                gtk-theme = "Adwaita-dark";
                show-battery-percentage = true;
              };

              "org/gnome/desktop/peripherals/touchpad" = {
                natural-scroll = false;
                two-finger-scrolling-enabled = true;
              };

              "org/gnome/desktop/screensaver" = {
                color-shading-type = "solid";
                picture-options = "zoom";
                primary-color = "#3465a4";
                secondary-color = "#000000";
              };

              "org/gnome/desktop/wm/keybindings" = {
                close = [ "<Super>q" ];
                move-to-workspace-1 = [ ];
                move-to-workspace-last = [ ];
                move-to-workspace-left = [ "<Shift><Super>Home" ];
                move-to-workspace-right = [ "<Shift><Super>End" ];
                switch-applications = [ ];
                switch-applications-backward = [ ];
                switch-to-workspace-1 = [ ];
                switch-to-workspace-last = [ ];
                switch-to-workspace-left = [ "<Super>Home" ];
                switch-to-workspace-right = [ "<Super>End" ];
                switch-windows = [ "<Alt>Tab" ];
                switch-windows-backward = [ "<Shift><Alt>Tab" ];
              };

              "org/gnome/desktop/wm/preferences" = {
                button-layout = "appmenu:minimize,maximize,close";
              };

              "org/gnome/mutter" = {
                experimental-features = [ "scale-monitor-framebuffer" ];
                workspaces-only-on-primary = false;
              };

              "org/gnome/settings-daemon/plugins/media-keys" = {
                custom-keybindings = [
                  "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
                  "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
                  "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
                ];
                help = [ ];
                home = [ "<Super>f" ];
                www = [ "<Super>b" ];
              };

              "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
                {
                  binding = "<Super>t";
                  command = "gnome-terminal";
                  name = "terminal";
                };

              "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" =
                {
                  binding = "<Super>e";
                  command = ''emacsclient -c -a ""'';
                  name = "emacsclient";
                };

              "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" =
                {
                  binding = "<Shift><Super>e";
                  command = "emacs";
                  name = "emacs";
                };

              "org/gnome/shell" = {
                disable-user-extensions = false;
                disabled-extensions = [
                  "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
                  "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
                  "window-list@gnome-shell-extensions.gcampax.github.com"
                  "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com"
                  "drive-menu@gnome-shell-extensions.gcampax.github.com"
                  "apps-menu@gnome-shell-extensions.gcampax.github.com"
                  "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
                ];
                enabled-extensions = [
                  "appindicatorsupport@rgcjonas.gmail.com"
                  "places-menu@gnome-shell-extensions.gcampax.github.com"
                ];
                favorite-apps = [
                  "firefox.desktop"
                  "org.gnome.Terminal.desktop"
                  "org.gnome.Nautilus.desktop"
                  "emacs.desktop"
                ];
                had-bluetooth-devices-setup = true;
                welcome-dialog-last-shown-version = "41.1";
              };

              "org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9" =
                {
                  audible-bell = false;
                  font = "DejaVu Sans Mono 20";
                  use-system-font = false;
                  visible-name = "michael";
                };

              "org/gnome/tweaks" = { show-extensions-notice = false; };
            }
          ]);

        user.extraGroups = [ "networkmanager" "uinput" ];
      };
    }

    (ifNixOS {
      environment = {
        variables = { TERM_APP = "gnome-terminal"; };
        systemPackages = with pkgs; [
          dconf2nix
          gnome.gnome-terminal
          gnome.gnome-tweaks
          gnomeExtensions.appindicator
          gnomeExtensions.reorder-workspaces
          wl-clipboard
          xclip
        ];
      };

      fonts = {
        packages = with pkgs; [
          noto-fonts
          noto-fonts-cjk
          noto-fonts-emoji
          noto-fonts-extra
        ];
      };

      hardware.pulseaudio.enable = false;

      i18n = {
        inputMethod = {
          enabled = "ibus";
          ibus.engines = with pkgs.ibus-engines; [ anthy rime ];
        };
      };

      security.rtkit.enable = true;

      services = {
        automatic-timezoned.enable = true;
        pipewire = {
          enable = true;
          alsa = {
            enable = true;
            support32Bit = true;
          };
          pulse.enable = true;
        };
        xserver = {
          desktopManager.gnome.enable = true;
          enable = true;
        };
      };

      sound.enable = false;
    })
  ]);
}
