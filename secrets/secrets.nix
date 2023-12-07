let
  tom =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMh8dXe/J5O97vJ/oTjZsDHkMmpbWDzFy0a3oQVJ4Ilq";

  users = [ tom ];

  grande =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINFHD0eY/TGHHtZPmxZjkM2aEza0/igtNIdMwXLPxuRI root@grande";

  systems = [ grande ];
in
{ "spotify-password.age".publicKeys = users ++ systems; }
