{
  description = "Nixos flake config, common accross all hostsystems";

  inputs = {

    ### UNIVERSAL FLAKE INPUTS ###

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ### MACHINE SPECIFIC FLAKE INPUTS ###

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    mkHost = { hostname }: nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/${hostname}/configuration.nix
        home-manager.nixosModules.default
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs hostname; };
          home-manager.users.niall = ./home.nix;
        }
      ];
    };
  in
  {
    nixosConfigurations.nialls-pc     = mkHost { hostname = "nialls-pc"; };
    nixosConfigurations.nialls-laptop = mkHost { hostname = "nialls-laptop"; };
  };
}