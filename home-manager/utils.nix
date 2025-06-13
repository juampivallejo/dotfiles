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
    unzip
    dig # DNS tool
    dust # Faster du (disk usage)
    hyperfine # Benchmarking tool
  ];

  programs.nh.enable = true;
  programs.yazi.enable = true; # file explorer
}
