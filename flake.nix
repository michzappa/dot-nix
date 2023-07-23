{
  description = "michzappa's nix configurations";

  inputs = {
    emacs.url = "github:nix-community/emacs-overlay";
    kmonad.url = "github:kmonad/kmonad?dir=nix";
    knock.url = "gitlab:michzappa/knock";

    home-manager.url = "github:nix-community/home-manager/release-23.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-23.05";
    nixpkgs-old.url = "github:NixOs/nixpkgs/nixos-22.11";
  };

  outputs = { self, ... }@inputs:
    with inputs;
    let
      mz-lib = (platform:
        inputs.nixpkgs.lib.extend (final: prev:
          inputs.home-manager.lib // {
            mz = import ./lib.nix {
              lib = final;
              platform = platform;
            };
          }));
    in {
      homeConfigurations = {
        etrange = inputs.home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {
            lib = mz-lib "home";
            platform = "home";
            systemName = "etrange";
            inputs = inputs;
          };
          pkgs = import inputs.nixpkgs {
            config.allowUnfree = true;
            system = "x86_64-linux";
          };
          modules = [ ./machines/etrange ./modules ];
        };
      };
      nixosConfigurations = {
        rorohiko = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            lib = mz-lib "nixos";
            platform = "nixos";
            systemName = "rorohiko";
            inputs = inputs;
          };
          system = "x86_64-linux";
          modules = [
            ./machines/rorohiko
            ./modules
            inputs.home-manager.nixosModule
            inputs.kmonad.nixosModules.default
            inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
          ];
        };
        vm = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            lib = mz-lib "nixos";
            platform = "nixos";
            systemName = "vm";
            inputs = inputs;
          };
          system = "x86_64-linux";
          modules = [
            ./machines/vm
            ./modules
            inputs.home-manager.nixosModule
            inputs.kmonad.nixosModules.default
          ];
        };
      };
    };
}
