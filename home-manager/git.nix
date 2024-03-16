{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Juan Pablo Vallejo";
    userEmail = "juampivallejo97@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
