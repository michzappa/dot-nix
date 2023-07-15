{ appimageTools, fetchurl }:

appimageTools.wrapType1 {
  name = "beeper";
  src = fetchurl {
    url = "https://download.beeper.com/linux/appImage/x64";
    hash = "sha256-Od8nuKeoQebpStR+33yJKMWf71Q9gvBqH10sGdd1PR4=";
  };
}
