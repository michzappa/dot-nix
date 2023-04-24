{ config, lib, modulesPath, pkgs, ... }: {
  imports = [ (modulesPath + "/virtualisation/qemu-vm.nix") ];

  boot = {
    extraModulePackages = [ ];
    initrd = {
      availableKernelModules =
        [ "ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    kernelParams = [ "console=tty1" "console=ttyS0,115200" ];
  };

  fileSystems."/" = {
    device = "/dev/vda1";
    fsType = "ext4";
  };

  virtualisation = {
    cores = 6;
    memorySize = 4096;
  };

  mz = {
    emacs.enable = true;
    fish.enable = true;
    git.enable = true;
    desktop.enable = true;
    user = {
      name = "vm-user";
      password = "";
    };
  };

  system.stateVersion = "22.05";

  time.timeZone = "America/New_York";

  users.mutableUsers = false;
}
