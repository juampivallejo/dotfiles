{ config, ... }: {
  xdg.configFile."zellij" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.xdg.configHome}/dotfiles/home-manager/zellij";
    recursive = true;
  };
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = false;
  };
}

