{ lib, ... }:
lib.mkProfile "four" {
  home = { config, ... }: {
    programs.ssh = {
      enable = true;
      includes = [ "${config.xdg.configHome}/ssh/config_four" ];
    };

    xdg.configFile = { "ssh/config_four".source = ./ssh_config_four; };

    programs.tmate = {
      enable = true;

      host = "tmate.thirty4.com";
      port = 2200;
      rsaFingerprint = "SHA256:MB++sg4DasdZeAtjVJH9lgKhDtVIBgWWbNLk2L97JNE";
      dsaFingerprint = "SHA256:knM9V8OvYnUQ2R7EwtxJa6b8bWgbUCV+qAsmKZs2JR4";
    };
  };
}
