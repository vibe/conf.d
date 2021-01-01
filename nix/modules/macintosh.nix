{ config, lib, pkgs, ... }:

let
  homeDir = builtins.getEnv("HOME");

in with pkgs.stdenv; with lib; {
  system.stateVersion = 4;
  nix.maxJobs = 8;
  nix.buildCores = 0;
  nix.package = pkgs.nix;
  services.nix-daemon.enable = true;

  nixpkgs.overlays = [ (import ../machines/macos/applications) ];
  nix.trustedUsers = [ "root" "vibe" ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  environment.shells = [ pkgs.zsh ];
  environment.systemPackages = [
    pkgs.zsh
    pkgs.gcc
    pkgs.vscode
    pkgs.Firefox
    pkgs.Sketch
    pkgs.skhd
    pkgs.IntelliJ
    pkgs.DataGrip
    pkgs.direnv
    pkgs.Docker
    pkgs.Chrome
    pkgs.Framer
    # pkgs.Cheatsheet - find somethign like this
  ];
  programs.bash.enable = false;
  programs.zsh.enable = true;
  environment.darwinConfig = mkDefault "${homeDir}/dev/lab/conf.d/nix/machines/macos/configuration.nix";

  time.timeZone = "America/New_York";
  users.users.vibe.shell = pkgs.zsh;
  users.users.vibe.home = homeDir;

  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = false;
      minimize-to-application = true;
      static-only = true;
    };

    screencapture.location = "${homeDir}/screenshots/";

    finder = {
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = true;
      FXEnableExtensionChangeWarning = false;
    };

    trackpad = {
      Clicking = true;
    };

    #NSGlobalDomain._HIHideMenuBar = true;
  };

  fonts.enableFontDir = true;
  fonts.fonts = with pkgs; [ fira-code font-awesome roboto roboto-mono ];

  system.keyboard = {
   enableKeyMapping = true;
   remapCapsLockToControl = true;
  };

  services.skhd.enable = true;
  services.skhd.skhdConfig = builtins.readFile ../../skhd/skhd.conf;

  services.lorri.enable = true;

  services.yabai = {
   enable = true;
   package = pkgs.yabai;
   enableScriptingAddition = true;
   config = {
     window_border              = "on";
     window_border_width        = 0;
     focus_follows_mouse        = "autoraise";
     mouse_follows_focus        = "off";
     window_placement           = "brother";
     window_opacity             = "off";
     window_topmost             = "on";
     window_shadow              = "float";
     active_window_opacity      = "1.0";
     normal_window_opacity      = "1.0";
     split_ratio                = "0.50";
     auto_balance               = "on";
     mouse_modifier             = "fn";
     mouse_action1              = "move";
     mouse_action2              = "resize";
     layout                     = "bsp";
     top_padding                = 0;
     bottom_padding             = 0;
     left_padding               = 0;
     right_padding              = 0;
     window_gap                 = 4;
    #  external_bar               = "all:26:0";
   };

   extraConfig = mkDefault ''
     # rules
     yabai -m rule --add app='System Preferences' manage=on
     yabai -m rule --add app='Live' manage=off
   '';
  };

  # Recreate /run/current-system symlink after boot
  services.activate-system.enable = true;

  home-manager.users.vibe = (import ../users/vibe/home.nix  { inherit config lib pkgs; });
}
