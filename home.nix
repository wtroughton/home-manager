{ config, pkgs, lib, ... }:

{
  imports = [
    (import ./config/neovim/default.nix)
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    any-nix-shell
    htop
    nodejs-16_x
    texlive.combined.scheme-full
    tmux
  ];

  programs.git = {
    enable = true;
    userName = "Winston Troughton";
    userEmail = "winston@troughton.net";
    extraConfig = {
      init = { defaultBranch = "main"; };
      github = { user = "wtroughton"; };
    };
  };

  programs.fish = {
    enable = true;

    shellAliases = {
      ls = "ls -F -h --color -v";
      ll = "ls -l";
      ".." = "cd ..";
    };

    interactiveShellInit = ''
      any-nix-shell fish --info-right | source
      set -Ux NIXPKGS_ALLOW_UNFREE 1
    '';
  };

  xdg.configFile."fish/conf.d/colorscheme.fish".source = ./config/fish/tokyonight_night.fish;

  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "ls -F -h --color -v";
      ll = "ls -l";
      ".." = "cd ..";
    };

    initExtra = ''
      exec fish
    '';
  };

  xdg.configFile."tmux/tmux.conf".text = ''
    # mouse support
    set -g mouse on

    set -g default-terminal "xterm-256color"

    # Overrides the default color
    set-option -ga terminal-overrides ",xterm-256color:Tc"
  '';

  nixpkgs.config.allowUnfree = true;
}
