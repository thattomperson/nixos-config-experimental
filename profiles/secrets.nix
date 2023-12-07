{ lib, agenix, ... }:
lib.mkProfile "secrets" {
  extraNixosModules = [ agenix.nixosModules.default ];
  nixos = { config, ... }: {
    profiles.openssh.enable = true;
    age.identityPaths =
      builtins.map (x: x.path) config.services.openssh.hostKeys;
  };
  extraHomeManagerModules = [ agenix.homeManagerModules.default ];
  home = { ... }:
    {

    };
}
