{ lib, ... }:
lib.mkProfile "fonts" {
  nixos = { pkgs, ... }: {

    fonts = {
      # use fonts specified by user rather than default ones
      enableDefaultPackages = false;
      fontDir.enable = true;

      packages = with pkgs; [
        # icon fonts
        material-design-icons
        font-awesome

        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        noto-fonts-extra

        source-sans
        source-serif

        # nerdfonts
        (nerdfonts.override {
          fonts = [ "FiraCode" "JetBrainsMono" "Iosevka" ];
        })
      ];

      # user defined fonts
      # the reason there's Noto Color Emoji everywhere is to override DejaVu's
      # B&W emojis that would sometimes show instead of some Color emojis
      fontconfig.defaultFonts = {
        serif = [ "Noto Serif" "Noto Color Emoji" ];
        sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
        monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
