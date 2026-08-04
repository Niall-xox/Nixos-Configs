# nialls-pc specific configurations

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common.nix
  ];

  # Defined hostname
  networking.hostName = "nialls-pc";

  # Hardware specific settings
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.cpu.amd.updateMicrocode = true;

  system.stateVersion = "26.05";

}