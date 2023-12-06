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
  };
  outputs = { nixlib, ... }@inputs:
    let
      importers = import ./lib/importers.nix { inherit (nixlib) lib; };
      lib = import ./lib {
        inherit (inputs) nixpkgs home-manager;
        lib = lib;
      };
    in {
      lib = lib;
      importers = importers;
      nixosConfigurations = {
        grande = lib.mkNixos {
          name = "grande";
          imports = [ ./hosts/grande.nix ];
          modules = importers.importExportableModules ./profiles;
          # OS Level modules
          profiles = { gnome.enable = true; };
          users = [
            {
              name = "tom";
              # User level modules, Can also include OS Level modules
              profiles = {
                # four.enable = true;
                # development.enable = true;
                games.enable = true;
              };
            }
            {
              name = "tegan";
              profiles = {
                # games.enable = true;
                # android.enable = true;
              };
            }
          ];
        };
      };
    };
}
