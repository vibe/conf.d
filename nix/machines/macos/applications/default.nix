{ config, lib, pkgs, ... }:

 let
  user = "vibe"; ##wtf is builtins.getEnv("LOGNAME") not working
  userPackages = config.home-manager.users.${user}.home.packages;
  docker-gui = pkgs.callPackage ./docker {};
  chrome = pkgs.callPackage ./chrome {};
  firefox = pkgs.callPackage ./firefox {};
  speedtest = pkgs.callPackage ./speedtest-cli {};

in {
  environment = {
    systemPackages = with pkgs; [
      zsh
      alacritty
      docker
      vscode

      #custom packages
      docker-gui
      chrome
      firefox
      speedtest
    ] ++ userPackages;
    
  };
    # Copy applications installed via Nix to ~ so Spotlight can index them

}
