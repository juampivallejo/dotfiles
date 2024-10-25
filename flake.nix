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
    home-manager-unstable = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
  };

  ## Outputs = built and working system configuration
  outputs = { home-manager, nixpkgs, nixos-wsl, ... }@inputs:
    let
      username = "juampi";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      # NixOS Configs
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/desktop/configuration.nix ./nixos ];
          specialArgs = { rose-pine-hyprcursor = inputs.rose-pine-hyprcursor; };
        };
        vm = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/vm/configuration.nix ./nixos ];
        };
        wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            [ nixos-wsl.nixosModules.wsl ./hosts/wsl/configuration.nix ];
        };
        wsl-desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            [ nixos-wsl.nixosModules.wsl ./hosts/wsl/configuration.nix ];
        };
      };

      # Home Manager Configs
      homeConfigurations = {
        "juampi@desktop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hosts/desktop/home.nix ./home-manager ];
          extraSpecialArgs = { inherit username pkgs-unstable; };
        };
        "juampi@vm" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hosts/vm/home.nix ./home-manager ];
          extraSpecialArgs = { inherit username; };
        };
        "juampi@wsl" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hosts/wsl/home.nix ./home-manager ];
          extraSpecialArgs = { inherit username pkgs-unstable; };
        };
        "juampi@wsl-desktop" =
          inputs.home-manager-unstable.lib.homeManagerConfiguration {
            pkgs = pkgs-unstable;
            modules = [ ./hosts/wsl/home.nix ./home-manager ];
            extraSpecialArgs = {
              inherit username
                pkgs-unstable; # This is the same as doing pkgs-unstable=pkgs-unstable
            };
          };
      };
    };
}
