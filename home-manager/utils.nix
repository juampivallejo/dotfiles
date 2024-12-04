{ pkgs, ... }: {
  home.packages = with pkgs; [
    ripgrep
    tldr
    btop
    htop
    eza
    bat
    gnumake # for fzf-native
    fzf
    jq
    jqp # playground for jq
    yq # jq for yaml
    rq
    fd
    zip
    dig # DNS tool
    nh # Nix cli tool
  ];
}
