{ pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    
    oh-my-zsh.enable = true;
    
    cdpath = [
      "."
      "~"
    ];

    history = {
      size = 50000;
      save = 500000;
      ignoreDups = true;
      share = true;
    };

    sessionVariables = {
      CLICOLOR = true;
    };

    shellAliases = {
        firefox=''open -n -a ~/Applications/Firefox\ Nightly.app --args -P antithesis'';
        firefox-nbcu=''open -n -a ~/Applications/Firefox\ Nightly.app --args -P nbcu'';
        firefox-ups=''open -n -a ~/Applications/Firefox\ Nightly.app --args -P ups'';
        chrome=''open -n -a ~/Applications/Google\ Chrome.app'';
        framer=''open -n -a ~/Applications/Framer.app'';
    };

    plugins = [
    {
        name = "pi-theme";
        file = "pi.zsh-theme";
        src = pkgs.fetchFromGitHub {
        owner = "tobyjamesthomas";
        repo = "pi";
        rev = "96778f903b79212ac87f706cfc345dd07ea8dc85";
        sha256 = "0zjj1pihql5cydj1fiyjlm3163s9zdc63rzypkzmidv88c2kjr1z";
        };
    }
    {
        name = "z";
        file = "zsh-z.plugin.zsh";
        src = pkgs.fetchFromGitHub {
        owner = "agkozak";
        repo = "zsh-z";
        rev = "41439755cf06f35e8bee8dffe04f728384905077";
        sha256 = "1dzxbcif9q5m5zx3gvrhrfmkxspzf7b81k837gdb93c4aasgh6x6";
        };
    }
    ];
  };
}