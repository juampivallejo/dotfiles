{ pkgs, ... }: {
  home.packages = with pkgs; [
    ripgrep
    tldr
    btop
    htop
    eza
    bat
    fzf
    jq
    jqp # playground for jq
    yq # jq for yaml
    rq
    fd
    zip
    yazi # file explorer
    dig # DNS tool
    nh # Nix cli tool
  ];
}
