{ nixpkgs, home-manager, lib, ... }@inputs: {
  mkNixos = config:
    let
      modules =
        builtins.map (module: import module { inherit lib; }) config.modules;
      nixosModules = builtins.map (module: module.nixosModules.default) modules;
      homeManagerModules =
        builtins.map (module: module.homeManagerModules.default) modules;
    in nixpkgs.lib.nixosSystem {
      system = if config ? system then config.system else "x86_64-linux";
      modules = [
        {
          networking.hostName = config.name;
          system.stateVersion =
            if config ? stateVersion then config.stateVersion else "23.11";
        }
        home-manager.nixosModules.home-manager
        {
          home-manager.sharedModules = homeManagerModules;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ] ++ nixpkgs.lib.forEach config.users (user: {
        users.users."${user.name}" = {
          name = user.name;
          home = if user ? home then user.home else "/home/${user.name}";
        };
        home-manager.users."${user.name}" = {
          home.stateVersion =
            if user ? stateVersion then user.stateVersion else "23.11";
          profiles = if user ? profiles then user.profiles else { };
        };
      }) ++ nixosModules;
    };

  mkProfile = name: profile: {
    nixosModules.default = { config, lib, pkgs, ... }@input:
      with lib;
      let
        cfg = config.profiles."${name}";
        usersSet = config.home-manager.users;
        usersList = (map (key: getAttr key usersSet) (attrNames usersSet));
        enableDefault = foldl' (x: y: x || y) false
          (map (user: user.profiles."${name}".enable) usersList);
      in {
        options.profiles."${name}" = {
          enable = mkOption {
            type = types.bool;
            default = enableDefault;
            description = ''
              Enable the ${name} profile
            '';
          };
        };
        config = mkIf cfg.enable (if profile ? nixos then
          profile.nixos { inherit (input) pkgs; }
        else
          { });
      };
    darwinModules.default = { config, lib, pkgs, ... }@input:
      with lib;
      let cfg = config.profiles."${name}";
      in {
        options.profiles."${name}" = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = ''
              Enable the ${name} profile
            '';
          };
        };
        config = mkIf cfg.enable (if profile ? darwin then
          profile.darwin { inherit (input) config lib pkgs; }
        else
          { });
      };
    homeManagerModules.default = { config, lib, pkgs, ... }@input:
      with lib;
      let cfg = config.profiles."${name}";
      in {
        options.profiles."${name}" = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = ''
              Enable the ${name} profile
            '';
          };
        };
        config = mkIf cfg.enable
          (if profile ? home then profile.home { inherit input; } else { });
      };
  };
}
