{ config, lib, pkgs }:
with config; with lib; {
    home.packages = (import ./packages.nix { inherit pkgs; });

    home.sessionVariables = {
      PAGER = "less -R";
      EDITOR = "vim";
    };

    programs.git.enable = true;
    programs.git.lfs.enable = true;
    programs.git.userName = mkDefault "Christian Franco";
    programs.git.userEmail = mkDefault ''${builtins.replaceStrings [" <at> " " <dot> "] ["@" "."] "dev <at> francoslab <dot> xyz"}'';
    programs.git.signing.key = mkDefault "4CF63957";
    programs.git.signing.signByDefault = mkDefault true;

    programs.firefox.enable = true;
    programs.firefox.package = pkgs.Firefox; # custom overlay
    programs.firefox.extensions =
      with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        privacy-badger
        multi-account-containers
        https-everywhere
      ];


    programs.firefox.profiles =
      let defaultSettings = {
            "app.update.auto" = true;
            "browser.startup.homepage" = "https://google.com";
            "browser.search.region" = "US";
            "browser.search.countryCode" = "US";
            "browser.search.isUS" = true;
            "browser.ctrlTab.recentlyUsedOrder" = false;
            "browser.newtabpage.enabled" = false;
            "browser.bookmarks.showMobileBookmarks" = true;
            "browser.uidensity" = 1;
            "browser.urlbar.placeholderName" = "DuckDuckGo";
            "browser.urlbar.update1" = true;
            "distribution.searchplugins.defaultLocale" = "en-US";
            "general.useragent.locale" = "en-US";
            "identity.fxaccounts.account.device.name" = config.networking.hostName;
            "privacy.trackingprotection.enabled" = true;
            "privacy.trackingprotection.socialtracking.enabled" = true;
            "privacy.trackingprotection.socialtracking.annotate.enabled" = true;
            "reader.color_scheme" = "sepia";
            "services.sync.declinedEngines" = "addons,passwords,prefs";
            "services.sync.engine.addons" = false;
            "services.sync.engineStatusChanged.addons" = true;
            "services.sync.engine.passwords" = false;
            "services.sync.engine.prefs" = false;
            "services.sync.engineStatusChanged.prefs" = true;
            "signon.rememberSignons" = false;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          };
      in {
        home = {
          id = 0;
          settings = defaultSettings;
          # userChrome = (builtins.readFile (pkgs.substituteAll {
          #   name = "homeUserChrome";
          #   src = ../conf.d/userChrome.css;
          #   tabLineColour = "#5e81ac";
          # }));
        };

        antithesis = {
          id = 1;
          settings = defaultSettings;
          # userChrome = (builtins.readFile (pkgs.substituteAll {
          #   name = "homeUserChrome";
          #   src = ../conf.d/userChrome.css;
          #   tabLineColour = "#5e81ac";
          # }));
        };

        work = {
          id = 2;
          settings = defaultSettings // {
            "browser.startup.homepage" = "about:blank";
            "browser.urlbar.placeholderName" = "Google";
          };
          # userChrome = (builtins.readFile (pkgs.substituteAll {
          #   name = "workUserChrome";
          #   src = ../conf.d/userChrome.css;
          #   tabLineColour = "#d08770";
          # }));
        };

        nbcu = {
          id = 3;
          settings = defaultSettings;
          # userChrome = (builtins.readFile (pkgs.substituteAll {
          #   name = "nbcuUserChrome";
          #   src = ../conf.d/userChrome.css;
          #   tabLineColour = "#0f9b9a";
          # }));
        };
        ups = {
          id = 4;
          settings = defaultSettings;
          # userChrome = (builtins.readFile (pkgs.substituteAll {
          #   name = "homeUserChrome";
          #   src = ../conf.d/userChrome.css;
          #   tabLineColour = "#400095";
          # }));
        };
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
    } ;

    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      sessionVariables = { RPROMPT = ""; };

      shellAliases = {
        firefox=''open -n -a ~/Applications/Firefox\ Nightly.app --args -P antithesis'';
        firefox-nbcu=''open -n -a ~/Applications/Firefox\ Nightly.app --args -P nbcu'';
        firefox-ups=''open -n -a ~/Applications/Firefox\ Nightly.app --args -P ups'';
        chrome=''open -n -a ~/Applications/Google\ Chrome.app'';
        framer=''open -n -a ~/Applications/Framer.app'';
      };

      oh-my-zsh.enable = true;

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



    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      extensions = (with pkgs.vscode-extensions; [
        bbenoist.Nix

      ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
              {
                name = "monochrome";
                publisher = "anotherglitchinthematrix";
                version = "2.3.0";
                sha256 = "114q6n51kb60xh1jh9yj5wh1d3a5bw7j4v34mismbr86smsd77z6";
              }
              {
                name = "aws-toolkit-vscode";
                publisher = "amazonwebservices";
                version = "1.17.0";
                sha256 = "0mgjp8shl4vgscpv4q03cfw2i2pyjv3dhx2a51q0czf842k9mpnj";
              }
              {
                name = "gitlens";
                publisher = "eamodio";
                version = "11.0.6";
                sha256 = "0qlaq7hn3m73rx9bmbzz3rc7khg0kw948z2j4rd8gdmmryy217yw";
              }
              {
                name = "vsc-community-material-theme";
                publisher = "Equinusocio";
                version = "1.4.2";
                sha256 = "1xll3dqicsssjw0b8was7jw43n1mdrlx5vcl15hq1va19rwyj28n";
              }
              {
                name = "vsc-material-theme";
                publisher = "Equinusocio";
                version = "33.1.2";
                sha256 = "14db0xmhcrk0lxafcgiqqzi1ydhiy16hs4r9g0jcdglj8bn6y624";
              }
              {
                name = "vsc-material-theme-icons";
                publisher = "equinusocio";
                version = "1.2.0";
                sha256 = "0wh295ncm8cbxmw9i3pvg703sn1gw7vp3slbklwjxskb4zivvfk4";
              }
              {
                name = "python";
                publisher = "ms-python";
                version = "2020.12.424452561";
                sha256 = "0zd0wdaip4nd9awr0h0m5afarzwhkfd8n9hzdahwf43sh15lqblf";
              }
              {
                name = "vscode-pylance";
                publisher = "ms-python";
                version = "2020.12.2";
                sha256 = "0dd2kwkb0a590jkhyg9kdl2fgmzky5yrkvijx41hw6f91gnhyl53";
              }
              {
                name = "jupyter";
                publisher = "ms-toolsai";
                version = "2020.12.414227025";
                sha256 = "1zv5p37qsmp2ycdaizb987b3jw45604vakasrggqk36wkhb4bn1v";
              }
              {
                name = "vsliveshare";
                publisher = "ms-vsliveshare";
                version = "1.0.3375";
                sha256 = "0mfjlfs24m8s2z0a80gh4j6sxwa7vwi6gqsgm0wk2wggb2bjvd0w";
              }
              {
                name = "vsliveshare-audio";
                publisher = "ms-vsliveshare";
                version = "0.1.91";
                sha256 = "0p00bgn2wmzy9c615h3l3is6yf5cka84il5331z0rkfv2lzh6r7n";
              }
              {
                name = "vsliveshare-pack";
                publisher = "ms-vsliveshare";
                version = "0.4.0";
                sha256 = "09h2yxpmbvxa3mz5wdnpb35h437f0z6j0n3blsb0d93jlwx5ydy5";
              }
              {
                name = "vscodeintellicode";
                publisher = "VisualStudioExptTeam";
                version = "1.2.10";
                sha256 = "1l980w4r18613hzwvqgnzm9csi72r9ngyzl94p39rllpiqy7xrhi";
              }
           ];
        userSettings = {

          "editor.formatOnSave" = false;
          "editor.minimap.enabled" = false;
          "editor.suggestSelection" ="first";
          "vsintellicode.modify.editor.suggestSelection" = "automaticallyOverrodeDefaultValue";
          "workbench.colorTheme" = "Material Theme Darker";
          "editor.tabSize" = 2;
          "files.trimTrailingWhitespace" = true;
          "workbench.activityBar.visible" = true;
          "breadcrumbs.enabled" = true;
          "git.autofetch" = true;
          "window.zoomLevel" = 0;
        };
    };

  }