{ config, lib, ... }: {
  programs.git = {
    enable = true;
    userName = "Juan Pablo Vallejo";
    userEmail = "juampivallejo97@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      color.ui = true;
      core.editor = "nvim";
    };
  };
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  services.ssh-agent = lib.mkIf config.isNixOS { enable = true; };
}
