{ lib, ... }:
lib.mkProfile "nix" {
  nixos = { lib, ... }: {
    nix = {

      gc = {
        # Improve nix store disk usage
        automatic = true;
      };

      settings = {
        # Prevents impurities in builds
        sandbox = true;

        # Give root user and wheel group special Nix privileges.
        trusted-users = [ "root" "@wheel" ];
      };

      # registry = {
      #   me = {
      #     from = {
      #       id = "me";
      #       type = "indirect";
      #     };
      #     to = {
      #       type = "git";
      #       url = "ssh://git@github.com/thattomperson/nix-config.git";
      #     };
      #   };
      # };
    };
  };
}
