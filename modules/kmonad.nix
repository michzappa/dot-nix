{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.kmonad;
in {
  options.mz.kmonad = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };

    # TODO break out into file per applicable machine.
    config = mkOption {
      type = types.str;
      default = ''
        (defsrc
          grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
          tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
          caps a    s    d    f    g    h    j    k    l    ;    '    ret
          lsft z    x    c    v    b    n    m    ,    .    /    rsft
          lctl lmet lalt           spc            ralt rctl)

        ;; template
        ;; (deflayer <name>
        ;;   _  _    _    _    _    _    _    _    _    _    _    _    _    _
        ;;   _  _    _    _    _    _    _    _    _    _    _    _    _    _
        ;;   _  _    _    _    _    _    _    _    _    _    _    _    _
        ;;   _  _    _    _    _    _    _    _    _    _    _    _
        ;;   _  _    _              _              _    _)

        (deflayer qwerty
          grv       1    2    3    4    5    6    7    8    9    0    -    =    bspc
          tab       q    w    e    r    t    y    u    i    o    p    [    ]    \
          ctl       a    s    d    f    g    h    j    k    l    ;    '    ret
          lsft      z    x    c    v    b    n    m    ,    .    /    rsft
          @caps_ctl lmet lalt           spc            ralt rctl)

        (deflayer colemak
          grv       1    2    3    4    5    6    7    8    9    0    -    =    bspc
          tab       q    w    f    p    g    j    l    u    y    ;    [    ]    \
          ctl       a    r    s    t    d    h    n    e    i    o    '    ret
          lsft      z    x    c    v    b    k    m    ,    .    /    rsft
          @caps_ctl lmet lalt           spc            ralt rctl)

        (defalias
          caps_ctl (tap-next caps lctl))
      '';
    };

    device = mkOption {
      type = types.str;
      default = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
    };

    name = mkOption {
      type = types.str;
      default = "internal";
    };
  };

  config = mkIf cfg.enable (ifNixOS {
    services = {
      kmonad = {
        enable = true;
        keyboards.${cfg.name} = {
          config = cfg.config;
          device = cfg.device;
          defcfg = {
            enable = true;
            allowCommands = false;
            fallthrough = true;
          };
        };
      };
    };
  });
}
