self: super: {
  Firefox = super.callPackage ./firefox {};
  Sketch = super.callPackage ./sketch {};
  Speedtest = super.callPackage ./speedtest-cli {};
  IntelliJ = super.callPackage ./intellij {};
  DataGrip = super.callPackage ./datagrip {};
  Cheatsheet = super.callPackage ./cheatsheet {};
  Docker = super.callPackage ./docker {};
  Chrome = super.callPackage ./chrome {};
  Framer = super.callPackage ./framer {};
  Pulumi = super.callPackage ./pulumi {};
  Discord = super.callPackage ./discord {};
  NoSQLWorkbench = super.callPackage ./nosql-workbench {};

  # TODO: Switch back to src build when SkyLight issue is fixed
  yabai = super.yabai.overrideAttrs (o: rec {
    version = "3.3.5";
    src = builtins.fetchTarball {
      url = "https://github.com/koekeishiya/yabai/releases/download/v${version}/yabai-v${version}.tar.gz";
      sha256 = "195n2sdw25iw4xvy3ydlxh0x2i39ni04bsqjl7wcf7dh57w10bj9";
    };

    installPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/share/man/man1/
      cp ./archive/bin/yabai $out/bin/yabai
      cp ./archive/doc/yabai.1 $out/share/man/man1/yabai.1
    '';
  });

  # spacebar = super.spacebar.overrideAttrs (o: {
  #   src = "${builtins.getEnv("HOME")}/src/github.com/cmacrae/spacebar";
  # });
}
