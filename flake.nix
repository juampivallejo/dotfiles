{
  description = "Home Manager and NixOS configuration of juampi";

  # Inputs = git repositories
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable"; # longer format is github:NixOS/nixpkgs/nixos-XX.XX
    nixpkgs-old.url = "nixpkgs/nixos-24.05";
    nixos-wsl.url = "github:nix-community/nixos-wsl";

    # Note: Used home-manager standalone install instructions (nix-shell '<home-manager>' -A install)
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix Darwin
    nix-darwin.url = "github:lnl7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Extras
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    # zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  ## Outputs = built and working system configuration
  outputs =
    {
      home-manager,
      nixpkgs,
      nixos-wsl,
      ...
    }@inputs:
    let
      username = "juampi";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-old = import inputs.nixpkgs-old {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      # NixOS Configs
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./options.nix
            ./hosts/desktop/configuration.nix
            ./nixos
          ];
          specialArgs = { inherit inputs pkgs-old; };
        };
        vm = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./options.nix
            ./hosts/vm/configuration.nix
            ./nixos
          ];
        };
        wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nixos-wsl.nixosModules.wsl
            ./options.nix
            ./hosts/wsl/configuration.nix
          ];
        };
        wsl-desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nixos-wsl.nixosModules.wsl
            ./options.nix
            ./hosts/wsl/configuration.nix
          ];
        };
      };

      darwinConfigurations = {
        JPs-iMac-Pro = inputs.nix-darwin.lib.darwinSystem {
          system = "x86_64-darwin"; # or "aarch64-darwin" for Apple Silicon
          modules = [
            ./options.nix
            ./hosts/macos/darwin.nix
          ];
          specialArgs = { inherit inputs username; };
        };
      };

      # Home Manager Configs
      homeConfigurations = {
        "juampi@desktop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./options.nix
            ./hosts/desktop/home.nix
            ./home-manager
          ];
          extraSpecialArgs = { inherit username inputs pkgs-old; };
        };
        "juampi@vm" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./options.nix
            ./hosts/vm/home.nix
            ./home-manager
          ];
          extraSpecialArgs = { inherit username; };
        };
        "juampi@wsl" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./options.nix
            ./hosts/wsl/home.nix
            ./home-manager
          ];
          extraSpecialArgs = { inherit username; };
        };
        "juampi@wsl-desktop" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs; # Same as inherit pkgs;
          modules = [
            ./options.nix
            ./hosts/wsl/home.nix
            ./home-manager
          ];
          extraSpecialArgs = { inherit username; };
        };
        "jp@JPs-iMac-Pro" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-darwin";
            config.allowUnfree = true;
          };
          modules = [
            ./options.nix
            ./hosts/macos/home.nix
            ./home-manager
          ];
          extraSpecialArgs = {
            username = "jp";
          };
        };
      };
    };
}
