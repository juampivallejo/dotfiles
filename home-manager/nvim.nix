{ config, ... }: {
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.xdg.configHome}/dotfiles/home-manager/nvim";
    recursive = true;
  };
}
