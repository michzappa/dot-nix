{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz; {
  # Multi-platform aliases for home-manager.
  options.mz.home = {
    dconf = mkOption {
      type = types.attrs;
      default = { };
    };

    file = mkOption {
      type = types.attrs;
      default = { };
    };

    packages = mkOption {
      type = types.listOf types.package;
      default = [ ];
    };

    programs = mkOption {
      type = types.attrs;
      default = { };
    };

    systemd = mkOption {
      type = types.attrs;
      default = { };
    };

    xdg-file = mkOption {
      type = types.attrs;
      default = { };
    };
  };

  config = (mkMerge [
    (ifNixSystem {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${config.mz.user.name} = {
          home = {
            file = mkAliasDefinitions options.mz.home.file;
            packages = mkAliasDefinitions options.mz.home.packages;
            stateVersion = config.system.stateVersion;
          };
          dconf = mkAliasDefinitions options.mz.home.dconf;
          programs = mkAliasDefinitions options.mz.home.programs;
          systemd = mkAliasDefinitions options.mz.home.systemd;
          xdg.configFile = mkAliasDefinitions options.mz.home.xdg-file;
        };
      };
    })

    (ifHomeManager {
      home = {
        file = mkAliasDefinitions options.mz.home.file;
        homeDirectory = mkAliasDefinitions options.mz.user.homeDir;
        packages = mkAliasDefinitions options.mz.home.packages;
        username = mkAliasDefinitions options.mz.user.name;
      };
      dconf = mkAliasDefinitions options.mz.home.dconf;
      programs = mkAliasDefinitions options.mz.home.programs;
      systemd = mkAliasDefinitions options.mz.home.systemd;
      xdg.configFile = mkAliasDefinitions options.mz.home.xdg-file;
    })

    (ifHomeManager { mz.home.programs.home-manager.enable = true; })
  ]);
}
