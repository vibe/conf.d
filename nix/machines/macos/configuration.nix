{ lib, config, pkgs, ...}:
with lib; {
  imports = attrValues (import ../../modules);
  networking.hostName = "vibe-macos";
}