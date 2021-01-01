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
    sha256 = "06v3fkmj8azwd6iar3xw1090dyiaci1y22ng6nwm1g31wy6rwsyr";
  };

  meta = with stdenv.lib; {
    description = "The Firefox web browser";
    homepage = "https://www.mozilla.org/en-GB/firefox";
    maintainers = [ maintainers.cmacrae ];
    platforms = platforms.darwin;
  };
}
