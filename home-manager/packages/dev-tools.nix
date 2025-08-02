{ config, pkgs, ... }: {
  home.packages = with pkgs;
    [
      onefetch # git info
      nushell # testing out nu shell
      nodejs_22 # Required for Copilot.lua
      kubectl
      k9s
      ## TEsting
      monitorets
      devtoolbox
      clapgrep
    ] ++ (if config.isNixOS then [
      lazydocker
      croc # File & folder transfer with relay server
      kubernetes-helm
    ] else
      [ ]);

  programs.lazygit.enable = true;
}
