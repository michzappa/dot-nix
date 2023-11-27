{ config, lib, modulesPath, pkgs, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    extraModulePackages = [ ];
    initrd = {
      availableKernelModules =
        [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
    kernelModules = [ "kvm-intel" ];
    plymouth.enable = true;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/root";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };

  swapDevices = [{ device = "/dev/disk/by-label/swap"; }];

  hardware.cpu.intel.updateMicrocode = true;

  powerManagement.cpuFreqGovernor = "powersave";

  services = {
    fstrim.enable = true;
    fwupd.enable = true;
  };

  networking = {
    firewall.enable = true;
    hostName = "rorohiko";
    interfaces.wlp166s0.useDHCP = true;
    useDHCP = false;
  };

  mz = {
    ada.enable = false;
    android.enable = false;
    direnv.enable = true;
    desktop.enable = true;
    docker.enable = false;
    emacs.enable = true;
    firefox.enable = true;
    fish.enable = true;
    formal-reasoning.enable = true;
    gaming.enable = true;
    git.enable = true;
    gnupg.enable = true;
    java.enable = false;
    kmonad.enable = true;
    typesetting.enable = true;
    mullvad.enable = true;
    nix.enable = true;
    nodejs.enable = false;
    ocaml.enable = false;
    protonmail.enable = false;
    syncthing.enable = true;
    toolchain.enable = true;
    virtualbox.enable = false;
  };

  system.stateVersion = "22.11";
}
