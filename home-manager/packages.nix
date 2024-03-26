{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Wallpapers
    swww
    arc-theme # gtk theme

    # Software
    rofi-wayland # Alternative App launcher
    slack # Messaging
    obsidian # Notes
    calibre # e-Books
    insomnia # Postman alternative
    stremio # streaming
    spotify
    discord

    # -- Development --
    kitty
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
