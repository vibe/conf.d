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
    sha256 = "Spi0owvmUrVUl4E6pJ5AWTTsobMuBZlXmOQOKOwKbD8=";
  };

  meta = with stdenv.lib; {
    description = "Framer - Bring every design to life in Framer.";
    homepage = "https://www.framer.com";
    maintainers = [ maintainers.vibe ];
    platforms = platforms.darwin;
  };
}
