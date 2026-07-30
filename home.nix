 {config, pkgs, ... }:

 {
  home.stateVersion = "26.05";
  home.username = "niall";
  home.homeDirectory = "/home/niall";

  programs.kitty = {
    enable = true;
    extraConfig = ''
      include themes/noctalia.conf
    '';

    settings = {
      background_opacity = "0.4";

      shell_integration = "no-cursor";
      cursor_shape = "block";
      cursor_shape_unfocused = "hollow";

      cursor_trail = "1";
      cursor_trail_decay = "0.1 0.4";
      cursor_trail_start_threshold = "0";
      # cursor_trail_color none

      scrollbar = "scrolled";
      scrollbar_jump_on_click = "no";

      enable_audio_bell = "no";

      confirm_os_window_close = "0";
    };
  };

programs.bash = {
  enable = true;
  enableCompletion = true;
  initExtra = ''
    fastfetch
  '';
};

programs.starship = {
  enable = true;
};

programs.fastfetch = {
  enable = true;
};

programs.cava = {
  enable = true;
};

 xdg.configFile."hypr/hyprland.lua".source = ./hyprland.lua;

 # Fire `hyprctl reload` once Noctalia has finished resolving the new
 # palette and rewriting theme templates (including ~/.config/hypr/noctalia.lua),
 # so Hyprland's colors update instantly on wallpaper switch instead of
 # requiring a manual reload.
 xdg.configFile."noctalia/hooks.toml".text = ''
   [hooks]
   colors_changed = "hyprctl reload"
 '';

  programs.home-manager.enable = true;

 }
