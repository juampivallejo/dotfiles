{ config, pkgs, ... }:
let
  devPackages = with pkgs; [
    # -- General Development Packages --
    lazygit
    gh
    awscli2
    devenv
  ];
  extrasNixOS = with pkgs;
    lib.optionals config.isNixOS [
      docker
      docker-compose
      kubectl
      k9s
      openssl
      gnumake
    ];
  extrasDarwin = with pkgs; lib.optionals config.isDarwin [ coreutils ];
in { home.packages = devPackages ++ extrasNixOS ++ extrasDarwin; }
