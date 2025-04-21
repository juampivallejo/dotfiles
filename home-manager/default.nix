{ ... }: {
  imports = [
    ./desktop-apps.nix
    ./direnv.nix
    ./fastfetch.nix
    ./git.nix
    ./hyprland
    ./nvim.nix
    ./packages.nix
    ./terminal.nix
    ./theme.nix
    ./tmux.nix
    ./utils.nix
    ./zellij
    ./zsh.nix
  ];
}
