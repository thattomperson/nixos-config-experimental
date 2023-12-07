{ lib, ... }:
lib.mkProfile "cli" {
  home = { pkgs, ... }: {
    profiles.fonts.enable = true;

    # basic configuration of git, please change to your own
    programs.git = {
      enable = true;
      userName = "Thomas Albrighton";
      userEmail = "thomasalbrighton@gmail.com";
    };

    # Packages that should be installed to the user profile.
    home.packages = with pkgs; [
      # here is some command line tools I use frequently
      # feel free to add your own or remove some of them
      # archives
      zip
      unzip

      # utils
      ripgrep # recursively searches directories for a regex pattern
      jq # A lightweight and flexible command-line JSON processor
      yq-go # yaml processor https://github.com/mikefarah/yq
      fzf # A command-line fuzzy finder

      # networking tools
      mtr # A network diagnostic tool
      iperf3
      dnsutils # `dig` + `nslookup`
      ldns # replacement of `dig`, it provide the command `drill`
      socat # replacement of openbsd-netcat
      nmap # A utility for network discovery and security auditing
      ipcalc # it is a calculator for the IPv4/v6 addresses

      # misc
      file
      which
      gnused
      gnutar
      gawk
      zstd
      gnupg

      # nix related
      #
      # it provides the command `nom` works just like `nix`
      # with more details log output
      nix-output-monitor

      # productivity
      glow # markdown previewer in terminal

      btop # replacement of htop/nmon
      iotop # io monitoring
      iftop # network monitoring

      # system call monitoring
      strace # system call monitoring
      ltrace # library call monitoring
      lsof # list open files

      # system tools
      sysstat
      lm_sensors # for `sensors` command
      ethtool
      pciutils # lspci
      usbutils # lsusb

      protonup-ng
      firefox
    ];

    # starship - an customizable prompt for any shell
    programs.starship = {
      enable = true;
      # custom settings
      settings = {
        add_newline = false;
        aws.disabled = true;
        gcloud.disabled = true;
        line_break.disabled = true;
      };
    };

    # alacritty - a cross-platform, GPU-accelerated terminal emulator
    programs.alacritty = {
      enable = true;
      # custom settings
      settings = {
        import = [
          "${pkgs.vimPlugins.nightfox-nvim}/extra/carbonfox/nightfox_alacritty.yml"
        ];
        env.TERM = "xterm-256color";
        window = {
          padding = {
            x = 12;
            y = 12;
          };
        };
        font = {
          size = 12;
          draw_bold_text_with_bright_colors = true;
          normal.family = "JetBrainsMono Nerd Font";
          bold.family = "JetBrainsMono Nerd Font";
          italic.family = "JetBrainsMono Nerd Font";
        };
        scrolling.multiplier = 5;
        selection.save_to_clipboard = true;
      };
    };

    programs.bash = {
      enable = true;
      enableCompletion = true;
      # TODO add your cusotm bashrc here
      bashrcExtra = ''
        export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      '';

      # set some aliases, feel free to add more or remove some
      shellAliases = {
        urldecode =
          "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
        urlencode =
          "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
      };
    };

    programs.zsh.enable = true;
  };
}
