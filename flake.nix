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
    outputs = {home-manager, nixpkgs, ...}:
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
            modules = [ ./nixos/configuration.nix ];
        };
    };

}
