{ config, pkgs-unstable, ... }:
{
  xdg.configFile."zellij" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/dotfiles/home-manager/zellij";
    recursive = true;
  };
  programs.zellij = {
    enable = true;
    package = pkgs-unstable.zellij;
    enableZshIntegration = true;
    enableFishIntegration = false;
  };
}
