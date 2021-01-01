{ stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "IntelliJ";
  version = "2020.3";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r IntelliJ\ IDEA.app "$out/Applications/IntelliJ IDEA.app"
    '';

  src = fetchurl {
    name = "ideaIU-${version}.dmg";
    url = "https://download-cf.jetbrains.com/idea/ideaIU-${version}.dmg";
    sha256 = "1pgjsk5hgy1vmn1cbamjlg6rwllhwpd4pbdr4plsnpzxpvvh6a0r";
  };

  meta = with stdenv.lib; {
    description = "Jetbrains";
    homepage = "https://www.jetbrains.com/idea/";
    maintainers = [ maintainers.vibe ];
    platforms = platforms.darwin;
  };
}
