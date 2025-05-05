# Setup GitHub ssh agent and key

```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
```

- Follow steps in this guide to configure ssh/.config in MacOS
  https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

- Then copy key and add to GH

```sh
pbcopy < ~/.ssh/id_ed25519.pub
```

# Install Nix

- Use Determinate Nix installer, select `No` to use the regular installer (nixos)

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install
```

# Install Home Manager (Standalone)

```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install
```

# Initialization

```sh
nix-shell -p nh
nh home switch .
```

# Next Steps

- Modularization of Home modules
- Setup nix-darwin modules with homebrew etc

# Install homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
