{
  description = "Home Manager and NixOS configuration of juampi";
  ## Inputs = some git repositories


  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11"; # longer format is github:NixOS/nixpkgs/nixos-XX.XX

    # Note: Used home-manager standalone install instructions (nix-shell '<home-manager>' -A install)
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  ## Outputs = built and working system configuration
  outputs = { home-manager, nixpkgs, ... }:
    let
      username = "juampi";
      vm-user = "juampi@vm";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/desktop/configuration.nix
          ./nixos
        ];
      };
      nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/vm/configuration.nix
          ./nixos
        ];
      };
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home-manager/home.nix
        ];
        extraSpecialArgs = { inherit username; };
      };
      homeConfigurations.${vm-user} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./hosts/vm/home.nix
          ./home-manager
        ];
        extraSpecialArgs = { inherit username; };
      };
    };

}
