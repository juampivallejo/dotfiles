{ config, lib, pkgs, ... }:
let
  workPackages = with pkgs; [
    # Beanstalk CLI
    awsebcli
    # Work
    aws-azure-login
  ];
  extras = with pkgs;
    lib.optionals config.isNixOS [
      ssm-session-manager-plugin # For ECS ssh
    ];

in { home.packages = workPackages ++ extras; }
