# Multi-platform Configuration of the Nix Package Manager
{ config, inputs, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.nix;
in {
  options.mz.nix = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      mz.home.packages = with pkgs; [ nix-diff nixfmt ];

      nix = {
        extraOptions = ''
          experimental-features = nix-command flakes
        '';
        package = pkgs.nix;
      };

      nixpkgs = {
        config.allowUnfree = true;
        overlays = [
          (self: super: {
            knock = inputs.knock.outputs.packages.${pkgs.system}.knock;
            beeper = pkgs.callPackage ../packages/beeper.nix { };
          })
          inputs.emacs.overlay
        ];
      };
    }

    (ifNixSystem {
      nix = {
        settings = {
          auto-optimise-store = true;
          trusted-users = [ "root" "@wheel" ];
        };
      };
    })

    (ifNixDarwin { services.nix-daemon.enable = true; })
  ]);
}
