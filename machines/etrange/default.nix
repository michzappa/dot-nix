{ config, lib, pkgs, ... }: {
  home.stateVersion = "21.11";

  mz = {
    direnv.enable = true;
    emacs.enable = true;
    firefox.enable = true;
    fish.enable = true;
    git.enable = true;
    gnome.enable = true;
    nix.enable = true;
  };
}
