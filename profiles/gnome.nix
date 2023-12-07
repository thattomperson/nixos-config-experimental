{ lib, ... }:
lib.mkProfile "gnome" {
  nixos = { ... }: {
    profiles.desktop.enable = true;

    services.xserver = {
      # Enable the GNOME Desktop Environment.
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
