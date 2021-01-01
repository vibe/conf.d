{ stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "DataGrip";
  version = "2020.3";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r DataGrip.app "$out/Applications/DataGrip.app"
    '';

  src = fetchurl {
    name = "datagrip-${version}.dmg";
    url = "https://download-cf.jetbrains.com/datagrip/datagrip-${version}.dmg";
    sha256 = "1aghyl70241k01n51049c6wn19zwhh62g7x9np2qgf30533ray12";
  };

  meta = with stdenv.lib; {
    description = "Jetbrains";
    homepage = "https://www.jetbrains.com/datagrip/";
    maintainers = [ maintainers.vibe ];
    platforms = platforms.darwin;
  };
}
