{ stdenv, fetchzip,fetchurl, undmg, zip, unzip }:

stdenv.mkDerivation rec {
  pname = "pulumi";
  version = "2.16.2";

  buildInputs = [ zip unzip ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/bin"
      cp pulumi/* $out/bin/
    '';

  src = fetchurl {
    url = "https://get.pulumi.com/releases/sdk/pulumi-v2.16.2-darwin-x64.tar.gz";
    sha256 = "0c80mdm568nahfbwx5yb5bfn9r19h53jyms50lfgp599zr1719rm";
  };

  meta = with stdenv.lib; {
    description = "Pulumi is an open source infrastructure as code tool for creating, deploying, and managing cloud infrastructure.";
    homepage = "https://pulumi.io/";
    maintainers = [ maintainers.vibe ];
    platforms = platforms.darwin;
  };
}
