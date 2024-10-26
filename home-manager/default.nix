{ ... }: {
  imports = [
    ./desktop-apps.nix
    ./git.nix
    ./theme.nix
    ./hyprland.nix
    ./kitty.nix
    ./neofetch.nix
    ./nvim.nix
    ./packages.nix
    ./tmux.nix
    ./utils.nix
    ./zsh.nix
    ./direnv.nix
  ];
}
