{ pkgs, lib, ... }:

{
  programs.git = {
    enable = true;

    userName = "Christian Franco";
    userEmail = "root@vibe.sh";

    signing = {
      key = "4CF63957";
      signByDefault = true;
    };

    lfs.enable = true;

    aliases = {};

    extraConfig = {};

    ignores = [
      "[._]*.s[a-v][a-z]"
      "[._]*.sw[a-p]"
      "[._]s[a-rt-v][a-z]"
      "[._]ss[a-gi-z]"
      "[._]sw[a-p]"
      "Session.vim"
      "Sessionx.vim"
      ".netrwhist"
      "*~"
      "tags"
      "[._]*.un~"
      "**/.idea/"
      "**/*.iml"
      "**/*.ipr"
      "**/*.iws"
      ".DS_Store"
      ".AppleDouble"
      ".LSOverride"
      "Icon"
      "._*"
      ".DocumentRevisions-V100"
      ".fseventsd"
      ".Spotlight-V100"
      ".TemporaryItems"
      ".Trashes"
      ".VolumeIcon.icns"
      ".com.apple.timemachine.donotpresent"
      ".AppleDB"
      ".AppleDesktop"
      "Network Trash Folder"
      "Temporary Items"
      ".apdisk"
    ];
  };
}