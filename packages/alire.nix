{ appimageTools, fetchurl }:

appimageTools.wrapType1 {
  name = "alr";
  src = fetchurl {
    url =
      "https://github.com/alire-project/alire/releases/download/v1.2.2/alr-1.2.2-x86_64.AppImage";
    hash = "sha256-DPE603EIAkaq5+TLMWBLZyAGid970mIraXLweC+0ZfQ=";
  };
}
