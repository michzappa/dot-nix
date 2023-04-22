# Fish Shell Configuration
{ config, inputs, lib, options, pkgs, systemName, ... }:
with lib;
with lib.mz;
let cfg = config.mz.fish;
in {
  options.mz.fish = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      mz = {
        home = {
          programs.fish = {
            enable = true;
            functions = let configPath = "~/dot-nix";
            in {
              build-nixos-vm =
                "nixos-rebuild build-vm --flake ${configPath}#vm";
              dev = "nix develop ${inputs.nixpkgs.outPath}#$argv[1]";
              dot-build = "nix build .#$argv[1]";
              gimme =
                "NIXPKGS_ALLOW_UNFREE=1 nix shell --impure ${inputs.nixpkgs.outPath}#$argv";
              lookup = "nix search path:${inputs.nixpkgs.outPath} $argv[1]";
              nix-clear-result-dirs = ''
                nix-store --gc --print-roots |\
                  awk '{print $1}' |\
                  grep /result |\
                  tee /dev/tty |\
                  sudo xargs rm
              '';
              reboot = "sudo shutdown -r now";
              rebuild-home =
                "home-manager $argv[1] --flake ${configPath}#${systemName}";
              rebuild-nixos =
                "nixos-rebuild --use-remote-sudo $argv[1] --flake ${configPath}#${systemName}";
              weather = ''
                if test (count $argv) -lt 1;
                   curl wttr.in
                else
                   curl wttr.in/$argv[1]
                end
              '';
            };
            interactiveShellInit = with pkgs; ''
              # disable the annoying $EDITOR keybindings by remapping to nop
              bind \ee true
              bind \ev true

              ${any-nix-shell}/bin/any-nix-shell fish --info-right | source

              set fish_greeting
              if [ $TERM != "dumb" ]
                function fish_mode_prompt; end
                function fish_prompt; end
                ${starship}/bin/starship init fish | source
              end
            '';
          };
          xdg-file."starship.toml".text = ''
            add_newline = false

            [character]
            success_symbol = "[➜](bold green)"

            [cmd_duration]
            min_time = 5
            show_milliseconds = true

            [directory]
            truncation_length = 0

            [package]
            disabled = true
          '';
        };
        user.shell = pkgs.fish;
      };
      programs.fish.enable = true;
    }

    (ifNixSystem { environment.shells = with pkgs; [ fish ]; })

    (ifNixDarwin {
      system.activationScripts.postActivation.text = ''
        sudo chsh -s ${pkgs.fish}/bin/fish ${config.mz.user.name}
      '';
    })
  ]);
}
