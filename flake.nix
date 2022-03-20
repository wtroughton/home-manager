{
  description = "MacOS Home Manager configuration";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { home-manager, ... }:
    let
      system = "x86_64-darwin";
      username = "winston";
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        # Specify the path to your home configuration here
        configuration = import ./home.nix;

        inherit system username;
        homeDirectory = "/Users/${username}";

        # Update the state version as needed.
        stateVersion = "22.05";

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
