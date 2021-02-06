{ pkgs, lib, ... }:

{
  imports = [
    ./bootstrap.nix
    ./system-defaults.nix
    ./services
    ./applications
  ];

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      hack-font fira-code font-awesome roboto roboto-mono
    ];
  };
}