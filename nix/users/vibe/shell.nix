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
  programs.alacritty = {
      enable = true;
      settings = {
        window.padding.x = 24;
        window.padding.y = 24;
        window.decorations = "buttonless";
        window.dynamic_title = false;
        scrolling.history = 100000;
        live_config_reload = true;
        selection.save_to_clipboard = true;
        mouse.hide_when_typing = true;

        font = {
          normal.family = "Roboto Mono";
          size = 12;
        };

        colors = {
          primary.background = "#2e3440";
          primary.foreground = "#d8dee9";

          normal = {
            black   = "#3b4252";
            red     = "#bf616a";
            green   = "#a3be8c";
            yellow  = "#ebcb8b";
            blue    = "#81a1c1";
            magenta = "#b48ead";
            cyan    = "#88c0d0";
            white   = "#e5e9f0";
          };

          bright = {
            black   = "#4c566a";
            red     = "#bf616a";
            green   = "#a3be8c";
            yellow  = "#ebcb8b";
            blue    = "#81a1c1";
            magenta = "#b48ead";
            cyan    = "#8fbcbb";
            white   = "#eceff4";
          };
        };

        key_bindings = [
          { key = "V"; mods = "Command"; action = "Paste"; }
          { key = "C"; mods = "Command"; action = "Copy";  }
          { key = "Q"; mods = "Command"; action = "Quit";  }
          { key = "Q"; mods = "Control"; chars = "\\x11"; }
          { key = "F"; mods = "Alt"; chars = "\\x1bf"; }
          { key = "B"; mods = "Alt"; chars = "\\x1bb"; }
          { key = "D"; mods = "Alt"; chars = "\\x1bd"; }
          { key = "Slash"; mods = "Control"; chars = "\\x1f"; }
          { key = "Period"; mods = "Alt"; chars = "\\e-\\e."; }
          { key = "N"; mods = "Command"; command = {
              program = "open";
              args = ["-nb" "io.alacritty"];
            };
          }
        ];
      };
    };
  
}