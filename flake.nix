{
  description = "Home Manager and NixOS configuration of juampi";
  ## Inputs = some git repositories

  inputs = {
    nixpkgs.url =
      "nixpkgs/nixos-24.05"; # longer format is github:NixOS/nixpkgs/nixos-XX.XX
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/nixos-wsl";

    # Note: Used home-manager standalone install instructions (nix-shell '<home-manager>' -A install)
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  ## Outputs = built and working system configuration
  outputs = { home-manager, nixpkgs, nixpkgs-unstable, nixos-wsl, ... }:
    let
      username = "juampi";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/desktop/configuration.nix ./nixos ];
      };
      nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/vm/configuration.nix ./nixos ];
      };
      nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          nixos-wsl.nixosModules.wsl
          ./hosts/wsl/configuration.nix
        ];
      };
      homeConfigurations."juampi@desktop" =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hosts/desktop/home.nix ./home-manager ];
          extraSpecialArgs = {
            inherit username;
            inherit pkgs-unstable;
          };
        };
      homeConfigurations."juampi@vm" =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hosts/vm/home.nix ./home-manager ];
          extraSpecialArgs = { inherit username; };
        };
      homeConfigurations."juampi@wsl" =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hosts/wsl/home.nix ./home-manager ];
          extraSpecialArgs = { inherit username; inherit pkgs-unstable; };
        };
    };

}
