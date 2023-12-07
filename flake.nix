{
  description = "Tom's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixlib.url = "github:nix-community/nixpkgs.lib";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };
  outputs = { nixlib, agenix, ... }@inputs:
    let
      importers = import ./lib/importers.nix { inherit (nixlib) lib; };
      lib = (import ./lib) inputs;
    in {
      lib = lib;
      importers = importers;
      nixosConfigurations = {
        grande = lib.mkNixos {
          name = "grande";
          specialArgs = { inherit (inputs) hardware; };
          imports = [ ./hosts/grande/default.nix ];
          modules = importers.importExportableModules ./profiles;

          # OS Level modules
          profiles = {
            gnome.enable = true;
            openssh.enable = true;
          };

          users = [
            {
              name = "tom";
              fullName = "Thomas Albrighton";
              email = "thomas.albrighton@four.io";
              groups = [ "wheel" ];
              # User level modules, Can also include OS Level modules
              profiles = {
                four.enable = true;
                razer.enable = true;
                # development.enable = true;
                gnome-autologin.enable = true;
                spotify.enable = true;
                games.enable = true;
                cli.enable = true;
              };
            }
            {
              name = "tegan";
              fullName = "Tegan Gidden";
              email = "tegan.giddens@four.io";

              profiles = {
                games.enable = true;
                razer.enable = true;
                cli.enable = true;
                # android.enable = true;
              };
            }
          ];
        };
      };
    };
}
