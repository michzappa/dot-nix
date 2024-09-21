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
      llvmPackages_13.clang
      clang-tools
      cmake
      gdb
      gnumake
      nasm
      pkg-config
      stdenv.cc.cc.lib
      valgrind
    ];
  };
}
