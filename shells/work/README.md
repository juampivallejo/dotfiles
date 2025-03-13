# Python38 Shell environment

- Add Numpy and Pandas pinned versions to keep compatibility with older python version

## About

Generic python shell environments, allowing multiple python versions.
Uses python package from `nixpkgs`, and uses `withPackages` to install additional dependencies

## Instructions

```
nix develop ~/.config/dotfiles/shells/work#
nix develop ~/.config/dotfiles/shells/work#python311
nix develop ~/.config/dotfiles/shells/work#python313
```

## What about dependencies not in `nixpkgs`?

Use the following:

- `pip2nix` to generate packages from `requirements.txt` files

```
nix run github:nix-community/pip2nix -- ./requirements.txt

-- or

nix shell github:nix-community/pip2nix
pip2nix generate "requests==2.32" numpy
pip2nix generate -r requirements.txt
```

- Then configure the flake with the extra packages:

```nix
{ pkgs ? import <nixpkgs> {} }:

let
  packageOverrides = pkgs.callPackage ./python-packages.nix {};
  python = pkgs.python3.override { inherit packageOverrides; };
in
pkgs.mkShell {
  packages = with pkgs; [
    # Imagine requests were not in nixpkgs and was overriden
    (python.withPackages(p: [p.requests]))
  ];
}
```
