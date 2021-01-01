{ stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "Docker";
  version = "stable";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r Docker.app "$out/Applications/Docker.app"
    '';

  src = fetchurl {
    name = "docker-${version}.dmg";
    url = "https://desktop.docker.com/mac/stable/Docker.dmg";
    sha256 = "1b8vpk2m65cdxprwgld25m5g9x4h9mcplg0izgqixg7wsk37qg6n";
  };

  meta = with stdenv.lib; {
    description = "Docker";
    homepage = "https://www.docker.com/";
    maintainers = [ maintainers.vibe ];
    platforms = platforms.darwin;
  };
}
