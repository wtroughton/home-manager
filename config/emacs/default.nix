{ pkgs, ... }:

{
  programs.emacs = {
    enable = false;               # install emacs with homebrew
  };

  # xdg.configFile."emacs/conf.d/colorscheme.fish".source = ./default.el;
}
