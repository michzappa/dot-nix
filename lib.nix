{ lib, platform, ... }:
with lib;
with lib.mz; {
  ifHomeManager = conf: (ifPlatforms [ "home" ] conf);

  ifNixDarwin = conf: (ifPlatforms [ "darwin" ] conf);

  ifNixOS = conf: (ifPlatforms [ "nixos" ] conf);

  ifNixSystem = conf: (ifPlatforms [ "darwin" "nixos" ] conf);

  ifPlatforms = optionPlatforms: conf:
    (optionalAttrs
      (foldr (optionPlatform: acc: (platform == optionPlatform) || acc) false
        optionPlatforms) conf);
}
