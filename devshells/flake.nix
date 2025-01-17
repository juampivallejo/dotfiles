{
  description = "nix devShell for Work environments";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-python.url = "github:cachix/nixpkgs-python";
  };

  outputs = { self, nixpkgs, nixpkgs-python }:
    let
      allSystems = [
        "x86_64-linux" # 64bit AMD/Intel x86
        "aarch64-darwin" # 64bit ARM macOS
      ];

      forAllSystems = fn:
        nixpkgs.lib.genAttrs allSystems (system:
          fn {
            pkgs = import nixpkgs {
              inherit system;
              config = { allowUnfree = true; };
            };
          });

    in {
      # $ nix develop
      devShells = forAllSystems ({ pkgs }: {
        default = pkgs.mkShell {
          name = "default shell";
          nativeBuildInputs = with pkgs; [
            nodejs_22
            # nixpkgs-python.packages.x86_64-linux."3.12"
            python312Full
            python312Packages.pandas
            python312Packages.numpy
          ];
          shellHook = ''
            export DIRENV=1
            export GITHUB_TOKEN=""
            source .venv/bin/activate
            zsh
          '';
        };
      });
    };
}
