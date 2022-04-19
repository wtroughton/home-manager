{ pkgs, ... }:

let
  neo-tree = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "neo-tree";
    src = pkgs.fetchgit {
      url = "https://github.com/nvim-neo-tree/neo-tree.nvim";
      rev = "a1f5f4b15cec517d632e7335d20400cb3f410606";
      sha256 = "Mxg+TNEwBMcEYVUiNxCjuiPtNnG+MSrcfn29YvXwboo=";
    };

    dependencies = ["nui" "plenary"];
  };

  nui = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "nui";
    src = pkgs.fetchgit {
      url = "https://github.com/MunifTanjim/nui.nvim";
      rev = "42552b3797c3452c5c94e0c84a04fbda9591b9d1";
      sha256 = "YWotqv+oqvKSDXu7TrlGrHdNBfr740Ccc2LPvH3C8T0=";
    };
  };

  plenary = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "plenary";
    src = pkgs.fetchgit {
      url = "https://github.com/nvim-lua/plenary.nvim";
      rev = "78dde9bc25af3e657eb829058bf179739f7e8e69";
      sha256 = "2pMJwzJ9NCY+pjkBiynOOOz+n3eeB5I917NWIzKpsws=";
    };
  };

in {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;

    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      neo-tree
      nui
      plenary
      nvim-web-devicons
      barbar-nvim
      coc-nvim
      telescope-nvim
      tokyonight-nvim
      which-key-nvim
    ];

    extraConfig = ''
      set mouse=a

      " This line enables the true color support.
      set termguicolors

      let g:tokyonight_style = "night"
      colorscheme tokyonight

      " Use filetype detection and file-based automatic indenting.
      filetype plugin indent on

      set tabstop=2
      set shiftwidth=2
      set expandtab
    '';
  };

  home.packages = with pkgs; [
    ripgrep
    fd
  ];
}
