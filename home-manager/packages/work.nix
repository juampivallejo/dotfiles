{ pkgs, ... }: {
  home.packages = with pkgs;
    [
      # Beanstalk CLI
      awsebcli
      # Work
      aws-azure-login
    ] ++ (if config.isNixOS then
      [
        ssm-session-manager-plugin # For ECS ssh
      ]
    else
      [ ]);
}
