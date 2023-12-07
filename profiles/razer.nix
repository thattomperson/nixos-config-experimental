{ lib, ... }:
lib.mkProfile "razer" {
  nixos = { pkgs, users, ... }: {

    # Add all users that have this profile enabled to the openrazer and packdev groups
    users.groups.openrazer.members = users;
    users.groups.packdev.members = users;

    # Enable mouse and keyboards drivers
    hardware.openrazer.enable = true;
    environment.systemPackages = with pkgs; [ openrazer-daemon polychromatic ];
  };
}
