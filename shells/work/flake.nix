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
            inherit system;
          });

      mkPythonEnv = { pkgs, system, pythonVersion ? "python312" }:
        let
          # Define the Python package to use
          python = pkgs.${pythonVersion};
        in pkgs.mkShell {
          name = "${pythonVersion} work shell";
          packages = [
            # Shell packages
            (python.withPackages (p:
              with p; [
                # Add pre installed packages
                ipdb
                numpy
                pandas
                debugpy
              ]))
          ];

          shellHook = ''
            export DIRENV=1
            if [ -d ".venv" ]; then
                source .venv/bin/activate
            elif [ -d "venv" ]; then
                source venv/bin/activate
            else
                echo "No virtual environment found. Please create either a 'venv' or '.venv' directory."
            fi
            source .env
          '';
        };

    in {
      # nix develop $FLAKE_PATH
      devShells = forAllSystems ({ pkgs, system }: {
        default = mkPythonEnv {
          inherit pkgs system;
          pythonVersion = "python312";
        };
        python311 = mkPythonEnv {
          inherit pkgs system;
          pythonVersion = "python311";
        };
        python312 = mkPythonEnv {
          inherit pkgs system;
          pythonVersion = "python312";
        };
        python313 = mkPythonEnv {
          inherit pkgs system;
          pythonVersion = "python313";
        };
      });
    };
}

