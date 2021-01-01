{ stdenv, fetchurl, undmg, zip, unzip }:

stdenv.mkDerivation rec {
  pname = "Framer";
  version = "latest";

  buildInputs = [ zip unzip ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r Framer.app "$out/Applications/Framer.app"
    '';

  src = fetchurl {
    name = "Framer-${version}.zip";
    url = "https://updates.framer.com/download-latest/com.framer.desktop";
    sha256 = "1l48chf8mxi9ihvf0b24pqw1c1x4r6jnmlrckp4m3mihz9x10mb3";
  };

  meta = with stdenv.lib; {
    description = "Framer - Bring every design to life in Framer.";
    homepage = "https://www.framer.com";
    maintainers = [ maintainers.vibe ];
    platforms = platforms.darwin;
  };
}
