{ appimageTools, fetchurl }:

appimageTools.wrapType1 {
  name = "beeper";
  src = fetchurl {
    url = "https://download.beeper.com/linux/appImage/x64";
    hash = "sha256-/LwEfBrrSW0aJcgKRSiGbP9MWwzENMiWlfzhAu5utSA=";
  };
}
