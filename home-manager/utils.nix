{ pkgs, ... }: {
  home.packages = with pkgs; [ 
    ripgrep
    tldr
    btop
    eza
    bat
    fzf
    jq
    rq
    fd
  ];
}
