{ pkgs, ... }: {
  home.packages = with pkgs; [
    ripgrep
    tldr
    btop
    eza
    bat
    gnumake # for fzf-native
    fzf
    jq
    rq
    fd
    zip
    dig # DNS tool
    nh # Nix cli tool
  ];
}
