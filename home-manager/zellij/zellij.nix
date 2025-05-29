{ config, ... }: {
  xdg.configFile."zellij/config.kdl".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.xdg.configHome}/dotfiles/home-manager/zellij/config.kdl";
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = false;
  };
}

