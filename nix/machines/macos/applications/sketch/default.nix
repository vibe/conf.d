{ stdenv, fetchurl, undmg, zip, unzip }:

stdenv.mkDerivation rec {
  pname = "Sketch";
  version = "Beta";

  buildInputs = [ zip unzip ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r Sketch\ Beta.app "$out/Applications/Sketch Beta.app"
    '';

  src = fetchurl {
    name = "Sketch-${version}.zip";
    url = "https://beta-download.sketch.com/sketch.zip";
    sha256 = "5AKce5V2sb4uf5a9SaMkPLDGQGMsfS4ofDzsfj7Tlks=";
  };

  meta = with stdenv.lib; {
    description = "Sketch - The Digital Design toolki";
    homepage = "https://www.sketch.com/";
    maintainers = [ maintainers.vibe ];
    platforms = platforms.darwin;
  };
}
