{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz; {
  # Multi-platform Aliases for User Options
  options.mz.user = {
    name = mkOption {
      type = types.str;
      default = "michael";
    };

    extraGroups = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };

    homeDir = mkOption {
      type = types.str;
      default = "/home/${config.mz.user.name}";
    };

    packages = mkOption {
      type = types.listOf types.package;
      default = [ ];
    };

    password = mkOption {
      type = types.nullOr types.str;
      default = null;
    };

    shell = mkOption {
      type = types.nullOr types.shellPackage;
      default = null;
    };
  };

  config = (ifNixSystem {
    security.sudo.wheelNeedsPassword = false;

    users.users.${config.mz.user.name} = (mkMerge [
      (ifNixOS {
        extraGroups = mkAliasDefinitions options.mz.user.extraGroups;
        isNormalUser = true;
        password = mkAliasDefinitions options.mz.user.password;
      })

      (ifNixOS { extraGroups = [ "wheel" ]; })

      {
        name = mkAliasDefinitions options.mz.user.name;
        home = mkAliasDefinitions options.mz.user.homeDir;
        packages = mkAliasDefinitions options.mz.user.packages;
        shell = mkAliasDefinitions options.mz.user.shell;
      }
    ]);
  });
}
