{ config, lib, pkgs, pkgs-old, ... }:
let
  workPackages = with pkgs;
    [
      # Beanstalk CLI
      pkgs-old.awsebcli
    ];
  extras = with pkgs;
    lib.optionals config.isNixOS [
      ssm-session-manager-plugin # For ECS ssh
      # Work
      aws-azure-login
    ];

in { home.packages = workPackages ++ extras; }
