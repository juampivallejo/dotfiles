{ pkgs, pkgs-unstable, ... }: {
  home.packages = with pkgs; [

    # -- General Development --
    git
    gh
    docker
    docker-compose
    awscli2
    cargo
    openssl

    # -- IDE --
    pkgs-unstable.neovim
    tmux

    # -- Python --
    python3Full
    python3Packages.pip

    # Dev Tools
    lazygit
    lazydocker

    # Golang Dev
    go
    gopls
    sqlc

    # Beanstalk CLI
    awsebcli
    ssm-session-manager-plugin # For ECS ssh

    # Neovim LSPs & Formatters
    pyright
    lua-language-server # Lua LSP
    nodePackages.cspell # Spelling Linter
    stylua # Lua formatter
    ruff # Python formatter
    isort # Python Sort
    nil # Nix LSP
    nixfmt # Nix format
    prettierd # Formatter
    shfmt # Shell formatter
    djlint # Django linter and formatter

    # Reptrak
    aws-azure-login
  ];

  programs.neovim.defaultEditor = true;
}
