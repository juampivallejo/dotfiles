{ config, pkgs, ... }: {
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.xdg.configHome}/dotfiles/home-manager/nvim";
    recursive = true;
  };

  home.packages = with pkgs; [
    # Neovim LSPs & Formatters
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
    copilot-language-server-fhs
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
