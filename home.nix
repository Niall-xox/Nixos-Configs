# home.nix common accross all systems

# Import hostname as it is defined in flake.nix (used to define monitors.lua)
{ config, pkgs, hostname, ... }:

{
  home.stateVersion = "26.05";
  home.username = "niall";
  home.homeDirectory = "/home/niall";

  # Kitty terminal settings including importing noctalia colours
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

  # Symlink for hyprland.lua and respective monitors.lua
  xdg.configFile."hypr/hyprland.lua".source = ./hyprland.lua;
  xdg.configFile."hypr/monitors.lua".source = ./hosts/${hostname}/monitors.lua;

  # Small script for running hyprctl reload when noctalia has changed wallpaper for instant hyrpland color changing
  xdg.configFile."noctalia/hooks.toml".text = ''
    [hooks]
    colors_changed = "hyprctl reload"
  '';

  # Enable home manager cli commands
  programs.home-manager.enable = true;

}