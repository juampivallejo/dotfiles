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
    difftastic = {
      enable = true;
      enableAsDifftool = true;
      display = "side-by-side-show-both";
    };
  };
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  services.ssh-agent = lib.mkIf config.isNixOS { enable = true; };
}
