{ stdenv, fetchgit, clang, gnumake, libusb1 }:

stdenv.mkDerivation {
  pname = "ch341eeprom";
  version = "0.5";

  src = fetchgit {
    url = "https://github.com/command-tab/ch341eeprom";
    rev = "d5b2fba35a33a1cddd7a3e920e1df933f21ba9b0";
    sha256 = "sha256-QUl5ErOfEfDhk1fF+BNu6n0Bake3IagNfn4I43b6Uns=";
  };

  buildInputs = [ clang gnumake libusb1 ];

  installPhase = ''
    mkdir -p $out/bin
    mv ch341eeprom $out/bin
  '';
}
