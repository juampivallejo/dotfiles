{ ... }: {
  imports = [
    ./base.nix
    ./dev-tools.nix
    ./go.nix
    ./python.nix
    ./rust.nix
    ./typescript.nix
    ./work.nix
  ];
}
