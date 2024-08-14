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
    openssl
    docker-compose

    # Golang Dev
    gopls
    sqlc

    # R studio
    rstudio

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
    nixfmt # Nix format
    prettierd # Formatter
    shfmt # Shell formatter
    djlint # Django linter and formatter
  ];

  programs.neovim.defaultEditor = true;
}
