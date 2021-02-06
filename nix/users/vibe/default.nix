{ config, pkgs, lib, ... }:
let
#   ca-bundle_crt = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
  sketch = pkgs.callPackage ../../machines/macos/applications/sketch {};
  intellij = pkgs.callPackage ../../machines/macos/applications/intellij {};
  datagrip = pkgs.callPackage ../../machines/macos/applications/datagrip {};
  framer = pkgs.callPackage ../../machines/macos/applications/framer {};
  pulumi = pkgs.callPackage ../../machines/macos/applications/pulumi {};
  discord = pkgs.callPackage ../../machines/macos/applications/discord {};
  no-sql-workbench = pkgs.callPackage ../../machines/macos/applications/nosql-workbench {};
  
in
rec {
  imports = [
    ./git.nix
    ./shell.nix
  ];

  home = {
    stateVersion = "20.09";

    sessionVariables = {
      EDITOR = "${pkgs.vim}/bin/vim";
      PAGER = "${pkgs.less}/bin/less";
    };

    packages = with pkgs; [
      vim
      wget
      sketch
      intellij
      datagrip
      framer
      pulumi
      discord
      no-sql-workbench
    ];
  };

  programs = {

    home-manager = { enable = true; };

    direnv = {
      enable = true;
      enableNixDirenvIntegration = true;
    };

    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };

  };

  xdg.enable = true;
}