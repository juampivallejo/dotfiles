{
  description = "Home Manager and NixOS configuration of juampi";
  ## Inputs = some git repositories

  inputs = {
    nixpkgs.url =
      "nixpkgs/nixos-unstable"; # longer format is github:NixOS/nixpkgs/nixos-XX.XX
    nixos-wsl.url = "github:nix-community/nixos-wsl";

    # Note: Used home-manager standalone install instructions (nix-shell '<home-manager>' -A install)
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  ## Outputs = built and working system configuration
  outputs = { home-manager, nixpkgs, nixos-wsl, ... }@inputs:
    let
      username = "juampi";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            mongodb-compass-overlay = prev.mongodb-compass.overrideAttrs
              (oldAttrs: {
                buildInputs = oldAttrs.buildInputs or [ ]
                  ++ [ final.makeWrapper ];
                buildCommand = ''
                  ${oldAttrs.buildCommand or ""}

                  # Custom wrapProgram invocation to include XDG_CURRENT_DESKTOP
                  wrapProgram $out/bin/mongodb-compass \
                    --set XDG_CURRENT_DESKTOP GNOME
                '';
              });
          })
        ];
      };
    in {
      # NixOS Configs
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/desktop/configuration.nix ./nixos ];
          specialArgs = { inherit inputs; };
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
          extraSpecialArgs = { inherit username inputs; };
        };
        "juampi@vm" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hosts/vm/home.nix ./home-manager ];
          extraSpecialArgs = { inherit username; };
        };
        "juampi@wsl" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hosts/wsl/home.nix ./home-manager ];
          extraSpecialArgs = { inherit username; };
        };
        "juampi@wsl-desktop" =
          inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = pkgs; # Same as inherit pkgs;
            modules = [ ./hosts/wsl/home.nix ./home-manager ];
            extraSpecialArgs = { inherit username; };
          };
      };
    };
}
