{
  description = "MacOS Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { home-manager, neovim-nightly-overlay, ... }:
    let
      system = "x86_64-darwin";
      username = "winston";
      overlays = [ neovim-nightly-overlay.overlay ];
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit system username;

        homeDirectory = "/Users/${username}";
        stateVersion = "22.05";

    	  extraModules = [
    	    { nixpkgs.overlays = overlays; }
    	  ];

        configuration = import ./home.nix;
      };
    };
}
