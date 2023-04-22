# General C/System Programming Toolchain
{ config, lib, options, pkgs, ... }:
with lib;
with lib.mz;
let cfg = config.mz.toolchain;
in {
  options.mz.toolchain = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = {
    mz.home.packages = with pkgs; [
      (hiPrio gcc)
      autoconf
      clang
      clang-tools
      cmake
      gdb
      gnumake
      nasm
      pkg-config
      valgrind
    ];
  };
}
