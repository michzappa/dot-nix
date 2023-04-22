# Load All Modules
{ lib, ... }:
let
  allModuleFiles = dir:
    lib.attrValues (lib.mapAttrs (name: _: dir + "/${name}") (lib.filterAttrs
      (fileName: _:
        (lib.hasSuffix ".nix" fileName) && fileName != "default.nix")
      (builtins.readDir dir)));
in { imports = (allModuleFiles ./.); }
