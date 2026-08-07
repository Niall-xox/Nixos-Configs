# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# This config is common accross all nixos systems. i made it myself yaay...

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.noctalia.nixosModules.default
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel. mkDefault set incase custom kernels used instead
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow propriatary packages eg. nvidia drivers
  nixpkgs.config.allowUnfree = true;

  # Enable GPU acceleration
  hardware.graphics.enable = true;

  # Enable sound
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
  security.rtkit.enable = true;

  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  # Enable Tailscale
  services.tailscale = {
    enable = true;
  };

  # Enable display manager (Ly)
  services.displayManager.ly.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.niall = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };

  # Enable Hyprland desktop enviroment
  programs.hyprland.enable = true;

  # Enable Noctalia shell (sourced from git in flake, not nixos packages)
  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    kitty
    vim
    nautilus
    libheif #for nautilus
    udiskie #for nautlius
    git
    xdg-user-dirs
    bibata-cursors
    grim
    slurp
    wl-clipboard
    nextcloud-client
    localsend
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    discord
    spotify
    vscodium
  ];

  # Nautlius file browser settings
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  nixpkgs.overlays = [
    (final: prev: {
      nautilus = prev.nautilus.overrideAttrs (nprev: {
        buildInputs =
          nprev.buildInputs
          ++ (with pkgs.gst_all_1; [
            gst-plugins-good
            gst-plugins-bad
          ]);
      });
    })
  ];
  environment.pathsToLink = [ "share/thumbnailers" ];

  # Steam settings
  programs.steam = {
    enable = true; # Master switch, already covered in installation
    remotePlay.openFirewall = true;  # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports for Source Dedicated Server hosting
    # Other general flags if available can be set here.
  };

  # Basic firewall with allowance for localsend: 53317
  networking.firewall = {
    enable = true;
    # enabled ports for localsend: 53317,
    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = [ 53317 ];
  };

}
