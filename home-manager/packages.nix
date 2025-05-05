{ pkgs, ... }: {
  home.packages = with pkgs; [

    # -- General Development --
    devenv
    git
    gh
    # docker
    # docker-compose
    awscli2
    cargo
    # openssl
    # gnumake

    # -- IDE --
    neovim
    tmux

    # -- Python --
    python3Full
    python3Packages.pip
    uv # Testing out uv as replacement of pip, pipenv and pyenv
    basedpyright

    # Dev Tools
    lazygit
    # lazydocker
    # onefetch # git info
    # nushell # testing out nu shell
    # nodejs_22 # Required for Copilot.lua
    kubectl
    k9s
    # croc # File & folder transfer with relay server
    # kubernetes-helm

    # Golang Dev
    # go
    # gopls
    # sqlc

    # Rust Dev
    rustc
    rust-analyzer
    rustfmt
    clippy
    vscode-extensions.vadimcn.vscode-lldb.adapter # For DAP

    # TypeScript Dev
    vtsls
    vscode-js-debug

    # Beanstalk CLI
    # awsebcli
    # ssm-session-manager-plugin # For ECS ssh

    # Neovim LSPs & Formatters
    pyright
    # nodePackages.cspell # Spelling Linter
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
    copilot-language-server-fhs

    # Work
    # cloudflare-warp
    # aws-azure-login
  ];

  programs.neovim.defaultEditor = true;
}
