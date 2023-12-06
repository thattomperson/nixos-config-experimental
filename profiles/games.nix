{ lib, ... }:
lib.mkProfile "games" {
  home = { ... }: { };
  nixos = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      mangohud
      protonup-ng
      r2modman
      steam-tui
      lutris
      steamcmd
      winetricks
      wineWowPackages.stable
    ];
    programs.steam.enable = true;
    programs.gamemode.enable = true;
  };
  darwin = { ... }: { programs.steam.enable = true; };
}
