{
    description = "Home Manager and NixOS configuration of juampi";
    ## Inputs = some git repositories


    inputs = {
        nixpkgs.url = "nixpkgs/nixos-23.11";  # longer format is github:NixOS/nixpkgs/nixos-XX.XX
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    ## Outputs = built and working system configuration
    outputs = {home-manager, nixpkgs, ...}@inputs:
        let
            username = "juampi";
            hostname = "nixos";
            system = "x86_64-linux";
            pkgs = import nixpkgs {
                inherit system;
                config.allowUnfree = true;
            };
        in {
        nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs username hostname; };
            modules = [ ./nixos/configuration.nix ];
        };
        homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            specialArgs = { inherit inputs username hostname; };
            modules = [ ./home-manager/home.nix ];
        };
    };

}
