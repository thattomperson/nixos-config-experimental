{ lib, ... }:
lib.mkProfile "gnome-autologin" {
  nixos = { users, ... }: {
    # Depend on gnome existing and being setup
    profiles.gnome.enable = true;

    # Enable automatic login for the user.
    services.xserver.displayManager.autoLogin.enable = true;
    services.xserver.displayManager.autoLogin.user = builtins.head users;

    # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;
  };
}
