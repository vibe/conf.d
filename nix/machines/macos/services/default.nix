{ config, lib, pkgs, ... }:

{
  services = {
    activate-system.enable = true;
    lorri.enable = true;
    skhd = {
        enable = true;
        skhdConfig = builtins.readFile ../../../../skhd/skhd.conf;
    };
    yabai = {
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
    };
};
}
