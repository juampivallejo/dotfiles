{ config, pkgs, ... }: {
  home.packages = with pkgs;
    [
      lazygit
      onefetch # git info
      nushell # testing out nu shell
      nodejs_22 # Required for Copilot.lua
      kubectl
      k9s
    ] ++ (if config.isNixOS then [
      lazydocker
      croc # File & folder transfer with relay server
      kubernetes-helm
    ] else
      [ ]);
}
