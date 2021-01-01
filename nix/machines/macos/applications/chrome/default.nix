{ stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "Chrome";
  version = "stable";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r Google\ Chrome.app "$out/Applications/Google Chrome.app"
    '';

  src = fetchurl {
    name = "Chrome-${version}.dmg";
    url = "https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg";
    sha256 = "1qzd9ih4mmysz1v8pqdbraf1rxqaidsdzwadhcd6hsn4h1m3q7i4";
  };

  meta = with stdenv.lib; {
    description = "The browser built by Google";
    homepage = "https://www.google.com/chrome/";
    maintainers = [ maintainers.vibe ];
    platforms = platforms.darwin;
  };
}
