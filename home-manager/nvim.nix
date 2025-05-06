{ config, pkgs, ... }: {
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.xdg.configHome}/dotfiles/home-manager/nvim";
    recursive = true;
  };

  home.packages = with pkgs;
    [
      # Neovim LSPs & Formatters
      pyright
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
      sleek # SQL formatter
      sqls # LSP
    ] ++ (if config.isNixOS then [
      copilot-language-server-fhs
      postgresql
      nodePackages.cspell # Spelling Linter
    ] else
      [ ]) ++ (if config.isDarwin then [ copilot-language-server ] else [ ]);

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
