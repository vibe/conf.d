{ stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "NoSQLWorkbench";
  version = "latest";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r "NoSQL Workbench.app" "$out/Applications/NoSQL Workbench.app"
    '';

  src = fetchurl {
    name = "nosql-workbench-${version}.dmg";
    url = "https://s3.amazonaws.com/nosql-workbench/NoSQL%20Workbench-mac-2.2.0.dmg";
    sha256 = "c5HWPmSiBwJOv6TOABBCmExu22oL1wx7OzcNxV5uKiA=";
  };

  meta = with stdenv.lib; {
    description = "NoSQL Workbench";
    homepage = "https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/workbench.settingup.html";
    maintainers = [ maintainers.vibe ];
    platforms = platforms.darwin;
  };
}
