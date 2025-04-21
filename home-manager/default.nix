{ ... }: {
  imports = [
    ./desktop-apps.nix
    ./direnv.nix
    ./fastfetch.nix
    ./git.nix
    ./hyprland.nix
    ./terminal.nix
    ./nvim.nix
    ./packages.nix
    ./rofi.nix
    ./theme.nix
    ./tmux.nix
    ./utils.nix
    ./zsh.nix
    ./zellij
  ];
}
