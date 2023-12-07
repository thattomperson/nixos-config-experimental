{ lib, ... }:
lib.mkProfile "openssh" {
  nixos = { ... }: { services.openssh.enable = true; };
}
