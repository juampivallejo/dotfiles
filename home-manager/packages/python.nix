{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # -- Python --
    python313
    python3Packages.pip
    uv # uv as replacement of pip, pipenv and pyenv
    basedpyright
    ty # rust lsp by Astral
  ];
}
