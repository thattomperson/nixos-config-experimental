{ lib, ... }:
lib.mkProfile "spotify" {
  home = { config, pkgs, ... }: {
    profiles.secrets.enable = true;

    age.secrets.spotify-password.file = ../secrets/spotify-password.age;

    services.spotifyd = {
      enable = true;
      settings = {
        global.username = "thomasalbrighton@gmail.com";
        global.password_cmd =
          "${pkgs.coreutils-full}/bin/cat ${config.age.secrets.spotify-password.path}";
      };
    };
    systemd.user.services.spotifyd.Unit.After = [ "agenix.service" ];
  };
}
