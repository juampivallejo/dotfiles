{ config, pkgs, ... }: {
  home.packages = with pkgs;
    [
      # -- General Development Packages --
      lazygit
      gh
      awscli2
      devenv
    ] ++ (if config.isNixOS then [
      docker
      docker-compose
      kubectl
      k9s
      openssl
      gnumake
    ] else
      [ ]) ++ (if config.isDarwin then [ coreutils ] else [ ]);

}
