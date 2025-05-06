{ config, lib, pkgs, ... }:
let
  workPackages = with pkgs;
    [
      # Beanstalk CLI
      awsebcli
    ];
  extras = with pkgs;
    lib.optionals config.isNixOS [
      ssm-session-manager-plugin # For ECS ssh
      # Work
      aws-azure-login
    ];

in { home.packages = workPackages ++ extras; }
