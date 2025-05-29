{ ... }: {
  imports = [
    ./desktop-apps.nix
    ./direnv.nix
    ./fish.nix
    ./fastfetch.nix
    ./git.nix
    ./hyprland
    ./nvim.nix
    ./packages
    ./terminal.nix
    ./theme.nix
    ./tmux.nix
    ./utils.nix
    ./zellij
    ./zsh.nix
  ];
}
