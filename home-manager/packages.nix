{ pkgs, ... }: {
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
    neovim
    tmux
    zellij

    # -- Python --
    python3Full
    python3Packages.pip
    uv # Testing out uv as replacement of pip, pipenv and pyenv
    basedpyright

    # Dev Tools
    lazygit
    lazydocker
    onefetch # git info
    nushell # testing out nu shell
    nodejs_22 # Required for Copilot.lua
    kubectl
    k9s

    # Golang Dev
    go
    gopls
    sqlc

    # Rust Dev
    rustc
    rust-analyzer
    rustfmt
    clippy
    vscode-extensions.vadimcn.vscode-lldb.adapter # For DAP

    # Beanstalk CLI
    awsebcli
    ssm-session-manager-plugin # For ECS ssh

    # Neovim LSPs & Formatters
    copilot-language-server
    pyright
    nodePackages.cspell # Spelling Linter
    lua-language-server # Lua LSP
    stylua # Lua formatter
    ruff # Python formatter
    isort # Python Sort
    nil # Nix LSP
    nixfmt-classic # Nix format
    prettierd # Formatter
    shfmt # Shell formatter
    djlint # Django linter and formatter
    # Neovim + SQL
    postgresql # To have psql executable
    sleek # SQL formatter
    sqls # LSP

    # Work
    # cloudflare-warp
    aws-azure-login
  ];

  programs.neovim.defaultEditor = true;
}
