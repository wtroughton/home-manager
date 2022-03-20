{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.tmux
  ];

  programs.git = {
    enable = true;
    userName = "Winston Troughton";
    userEmail = "winston@wlt.dev";
    extraConfig = {
      init = { defaultBranch = "main"; };
      github = { user = "wtroughton"; };
    };
  };

  programs.fish = {
    enable = true;
  };
}
