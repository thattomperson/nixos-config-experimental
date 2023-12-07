{ lib, ... }:
lib.mkProfile "desktop" {
  nixos = { pkgs, ... }: {
    services.xserver = {
      # Enable the X11 windowing system.
      enable = true;

      # Configure keymap
      layout = "us";
      xkbVariant = "";
    };

    # Enable networking
    networking.networkmanager.enable = true;

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

  };
}
