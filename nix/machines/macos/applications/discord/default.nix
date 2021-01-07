{ stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "Docker";
  version = "stable";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r Discord.app "$out/Applications/Discord.app"
    '';

  src = fetchurl {
    name = "discord-${version}.dmg";
    url = "https://dl.discordapp.net/apps/osx/0.0.260/Discord.dmg";
    sha256 = "1210ng47bqx7id9plzzfxmrb7sgx2f6b74bm52h4abl67nqsppcw";
  };

  meta = with stdenv.lib; {
    description = "Docker";
    homepage = "https://www.discord.com/";
    maintainers = [ maintainers.vibe ];
    platforms = platforms.darwin;
  };
}
