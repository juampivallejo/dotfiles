{ pkgs, pkgs-unstable, ... }: {
  home.packages = with pkgs; [
    # -- Development --
    tmux
    pkgs-unstable.neovim
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

    # Beanstalk CLI
    awsebcli
    ssm-session-manager-plugin # For ECS ssh

    # Neovim LSPs & Formatters
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
