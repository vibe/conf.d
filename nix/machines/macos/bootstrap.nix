{ config, pkgs, lib, ... }:

{
  nix = {
    binaryCaches = [
      "https://cache.nixos.org/"
    ];

    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];

    trustedUsers = [
      "vibe"
    ];

    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  services = {
    nix-daemon.enable = true;
  };

  programs.nix-index.enable = true;

  # programs.fish.enable = true;
  programs.bash.enable = true;

  programs.zsh = {
    enable = true;
    enableFzfCompletion = true;
    enableFzfGit = true;
    enableFzfHistory = true;
    promptInit = ''
    '';
  };

  system.stateVersion = 0;
}
