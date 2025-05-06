{ config, lib, pkgs, ... }:
let
  basePackages = with pkgs; [
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
  ];
  nixosPackages = with pkgs;
    lib.optionals config.isNixOS [
      copilot-language-server-fhs
      postgresql
      nodePackages.cspell # Spelling Linter
    ];
  darwinPackages = with pkgs;
    lib.optionals config.isDarwin [
      copilot-language-server # install darwin
    ];

in {
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.xdg.configHome}/dotfiles/home-manager/nvim";
    recursive = true;
  };

  home.packages = basePackages ++ nixosPackages ++ darwinPackages;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
