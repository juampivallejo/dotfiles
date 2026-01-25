{ config, lib, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Juan Pablo Vallejo";
        email = "juampivallejo97@gmail.com";
      };
      init.defaultBranch = "main";
      color.ui = true;
      core.editor = "nvim";
    };
  };
  programs.ssh = {
    matchBlocks."*" = {
      enable = true;
      addKeysToAgent = true;
    };
  };
  programs.difftastic = {
    git = {
      enable = true;
      diffToolMode = true;
    };
    options = {
      display = "Side-by-side";
    };
  };

  services.ssh-agent = lib.mkIf config.isNixOS { enable = true; };
}
