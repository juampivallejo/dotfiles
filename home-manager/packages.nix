{ pkgs, ... }: {
  home.packages = with pkgs; [
    # -- Development --
    tmux
    neovim
    git
    gh
    docker
    python3Full
    python3Packages.pip
    awscli2
    go
    cargo
    lazygit
    nodePackages.cspell

    # Golang Dev
    gopls
    sqlc

    nodePackages.pyright
    nodePackages.vscode-json-languageserver
    lua-language-server
    stylua # Lua formatter
    ruff # Python formatter
    isort # Python Sort
    nil # Nix LSP
    nixpkgs-fmt # Nix format
    prettierd # Formatter
    shfmt # Shell formatter
  ];

  programs.neovim.defaultEditor = true;
}
