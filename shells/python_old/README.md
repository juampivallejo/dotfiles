# Python38 Shell environment

- Add Numpy and Pandas pinned versions to keep compatibility with older python version

## About

Generic python shell environments, allowing multiple python versions.

Uses `github:cachix/nixpkgs-python` to retrieve legacy python versions. Also it sets the
`LD_LIBRARY_PATH` variable to the correct path to the python libraries like Numpy and Pandas.

## Instructions

```
nix develop ~/.config/dotfiles/shells/python_old#
nix develop ~/.config/dotfiles/shells/python_old#python39
```
