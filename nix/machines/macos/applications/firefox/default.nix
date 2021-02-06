{ stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "Firefox";
  version = "nightly";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r Firefox\ Nightly.app "$out/Applications/Firefox Nightly.app"
    '';

  src = fetchurl {
    name = "Firefox-${version}.dmg";
    url = "https://download.mozilla.org/?product=firefox-nightly-latest-ssl&os=osx&lang=en-US";
    sha256 = "sha256-UEm5IWEggaQ+vJaHPd04DgTJ+ayvwSKff7jj1MoTZmY=";
  };

  meta = with stdenv.lib; {
    description = "The Firefox web browser";
    homepage = "https://www.mozilla.org/en-GB/firefox";
    maintainers = [ maintainers.vibe ];
    platforms = platforms.darwin;
  };
}
