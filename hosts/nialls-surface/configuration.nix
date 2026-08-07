# nialls-surface specific configuration (Surface Pro 8, Intel)

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common.nix
    inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
  ];

  networking.hostName = "nialls-surface";

  # common.nix turns these on unconditionally — force them off here
  services.displayManager.ly.enable = lib.mkForce false;
  programs.hyprland.enable = lib.mkForce false;
  programs.noctalia.enable = lib.mkForce false;

  # GNOME + GDM instead
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  system.stateVersion = "26.05"; # match nixos-generate-config on first install
}
